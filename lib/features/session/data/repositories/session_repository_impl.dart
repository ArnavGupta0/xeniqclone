import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:xeniqclone/features/call/services/webrtc_manager.dart';
import 'package:xeniqclone/features/session/domain/repositories/session_repository.dart';
import 'package:xeniqclone/services/grpc_service.dart';
import 'package:xeniqclone/src/generated/xeniq.pb.dart';

/// Session Repository Implementation - Manages WebRTC sessions with gRPC signaling
/// 
/// Responsibilities:
/// - Create/join sessions
/// - Manage WebRTCManager lifecycle
/// - Handle gRPC StreamConnection bidirectional signaling
/// - Exchange SDP offers/answers and ICE candidates
/// - Expose media streams to UI
class SessionRepositoryImpl implements SessionRepository {
  WebRTCManager? _webrtcManager;
  
  final _localStreamController = StreamController<MediaStream>.broadcast();
  final _remoteStreamController = StreamController<MediaStream>.broadcast();
  final _sessionEventsController = StreamController<Map<String, dynamic>>.broadcast();
  
  StreamController<ConnectionEvent>? _signalingRequestController;
  StreamSubscription<ConnectionEvent>? _signalingSubscription;
  
  String? _currentSessionId;
  String? _myUserId;
  String? _peerUserId;
  bool _isProvider = false;
  
  // ICE candidate buffering
  List<RTCIceCandidate> _iceCandidateBuffer = [];
  bool _remoteDescriptionSet = false;
  
  // Session state guard to prevent phantom calls
  bool _sessionActive = false;
  
  // Force-exit callback for auto call termination
  VoidCallback? _onCallEnded;

  @override
  Stream<MediaStream> get localStream => _localStreamController.stream;

  @override
  Stream<MediaStream> get remoteStream => _remoteStreamController.stream;

  @override
  Stream<Map<String, dynamic>> get sessionEvents => _sessionEventsController.stream;

  /// Set callback to be invoked when call is forcefully ended
  @override
  void setOnCallEndedCallback(VoidCallback callback) {
    _onCallEnded = callback;
  }

  /// Force end call and notify UI
  void _forceEndCall(String reason) {
    if (!_sessionActive) return;
    _sessionActive = false; // Set BEFORE cleanup to prevent re-entry
    log('🛑 [SESSION] Force ending call: $reason');
    
    // Cleanup WebRTC
    _webrtcManager?.dispose();
    _webrtcManager = null;
    
    // Close signaling (don't await, just fire and forget)
    _signalingSubscription?.cancel();
    _signalingRequestController?.close();
    _signalingRequestController = null;
    _signalingSubscription = null;
    
    // Reset state
    _currentSessionId = null;
    _myUserId = null;
    _peerUserId = null;
    _remoteDescriptionSet = false;
    _iceCandidateBuffer.clear();
    
    // Notify UI to exit LAST
    _onCallEnded?.call();
  }

  /// Create session (Provider side - called after accepting call)
  /// 
  /// Flow:
  /// 1. Initialize WebRTC as responder
  /// 2. Open gRPC signaling stream
  /// 3. Wait for consumer's offer
  /// 4. Create and send answer
  @override
  Future<String> createSession(String sessionId) async {
    // GUARD: Prevent duplicate session creation
    if (_sessionActive) {
      log('⚠️ [SESSION] Ignoring duplicate createSession - session already active');
      return _currentSessionId ?? sessionId;
    }
    
    log('🎬 [SESSION] Creating session: $sessionId (Provider side)');
    
    try {
      _sessionActive = true;
      _currentSessionId = sessionId;
      _isProvider = true;
      // TODO: Get actual user IDs from auth
      _myUserId = 'provider-$sessionId';
      _peerUserId = 'consumer-$sessionId';

      // 1. Initialize WebRTC
      _webrtcManager = WebRTCManager(
        onLocalSDP: _handleLocalSDP,
        onICECandidate: _handleICECandidate,
        onRemoteStream: _handleRemoteStream,
        onConnectionStateChange: _handleConnectionStateChange,
      );

      await _webrtcManager!.init(
        isInitiator: false, // Provider is ALWAYS responder
        isProvider: true,   // Use rear camera
      );

      // 2. Expose local stream
      if (_webrtcManager!.localStream != null) {
        _localStreamController.add(_webrtcManager!.localStream!);
      }

      // 3. Open gRPC signaling stream
      await _openSignalingStream();

      // 4. Send initial message to register stream with backend
      // Backend blocks on stream.Recv() and needs first message to register provider
      if (_signalingRequestController != null && !_signalingRequestController!.isClosed) {
        final readyEvent = ConnectionEvent(
          callId: _currentSessionId!,
          senderId: _myUserId!,
          receiverId: _peerUserId!,
        );
        _signalingRequestController!.add(readyEvent);
        log('📤 [SESSION] Provider ready message sent to backend');
      }

      log('✅ [SESSION] Session created successfully');
      return sessionId;
    } catch (e) {
      log('❌ [SESSION] Create session failed: $e');
      rethrow;
    }
  }

  /// Join session (Consumer side - called when joining a call)
  /// 
  /// Flow:
  /// 1. Initialize WebRTC as initiator
  /// 2. Open gRPC signaling stream
  /// 3. Create and send offer
  /// 4. Wait for provider's answer
  @override
  Future<void> joinSession(String sessionId) async {
    // GUARD: Prevent duplicate session join
    if (_sessionActive) {
      log('⚠️ [SESSION] Ignoring duplicate joinSession - session already active');
      return;
    }
    
    log('🎬 [SESSION] Joining session: $sessionId (Consumer side)');
    
    try {
      _sessionActive = true;
      _currentSessionId = sessionId;
      _isProvider = false;
      // TODO: Get actual user IDs from auth
      _myUserId = 'consumer-$sessionId';
      _peerUserId = 'provider-$sessionId';

      // 1. Initialize WebRTC
      _webrtcManager = WebRTCManager(
        onLocalSDP: _handleLocalSDP,
        onICECandidate: _handleICECandidate,
        onRemoteStream: _handleRemoteStream,
        onConnectionStateChange: _handleConnectionStateChange,
      );

      await _webrtcManager!.init(
        isInitiator: true,  // Consumer ALWAYS initiates
        isProvider: false,  // Use front camera
      );

      // 2. Open gRPC signaling stream
      await _openSignalingStream();

      // 3. Create offer (consumer starts negotiation)
      await Future.delayed(const Duration(milliseconds: 500)); // Let stream stabilize
      await _webrtcManager!.createOffer();

      log('✅ [SESSION] Joined session and sent offer');
    } catch (e) {
      log('❌ [SESSION] Join session failed: $e');
      rethrow;
    }
  }

  /// Open bidirectional gRPC signaling stream
  Future<void> _openSignalingStream() async {
    log('📡 [SESSION] Opening gRPC signaling stream...');

    try {
      _signalingRequestController = StreamController<ConnectionEvent>();
      
      final stream = GrpcService().connectClient.streamConnection(
        _signalingRequestController!.stream,
      );

      _signalingSubscription = stream.listen(
        _handleSignalingEvent,
        onError: (error) {
          log('❌ [SESSION] Signaling stream error: $error');
          _forceEndCall('stream_error');
        },
        onDone: () {
          log('📡 [SESSION] Signaling stream closed');
          _forceEndCall('stream_closed');
        },
      );

      log('✅ [SESSION] Signaling stream opened');
    } catch (e) {
      log('❌ [SESSION] Failed to open signaling stream: $e');
      rethrow;
    }
  }

  /// Handle incoming signaling events from peer
  void _handleSignalingEvent(ConnectionEvent event) {
    log('📥 [SESSION] Received signaling event: ${event.whichPayload()}');

    switch (event.whichPayload()) {
      case ConnectionEvent_Payload.sdp:
        _handleRemoteSDP(event.sdp);
        break;
      case ConnectionEvent_Payload.ice:
        _handleRemoteICE(event.ice);
        break;
      case ConnectionEvent_Payload.end:
        _handleCallEnd(event.end);
        break;
      default:
        log('⚠️ [SESSION] Unknown payload type');
    }
  }

  /// Handle remote SDP (offer or answer) - WITH ROLE ENFORCEMENT
  Future<void> _handleRemoteSDP(SessionDescription sdp) async {
    log('📋 [SESSION] Received remote SDP - Type: ${sdp.type}');

    // ENFORCE SDP ROLES
    if (sdp.type == 'offer' && !_isProvider) {
      log('❌ [SESSION] Consumer received offer - INVALID! Consumer should only receive answers.');
      return; // Drop invalid SDP
    }
    
    if (sdp.type == 'answer' && _isProvider) {
      log('❌ [SESSION] Provider received answer - INVALID! Provider should only receive offers.');
      return; // Drop invalid SDP
    }

    try {
      final rtcSdp = RTCSessionDescription(sdp.sdp, sdp.type);
      await _webrtcManager?.setRemoteDescription(rtcSdp);
      _remoteDescriptionSet = true;
      
      log('✅ [SESSION] Remote description set successfully');
      
      // Flush buffered ICE candidates
      if (_iceCandidateBuffer.isNotEmpty) {
        log('🧊 [ICE] Flushing ${_iceCandidateBuffer.length} buffered candidates');
        for (final candidate in _iceCandidateBuffer) {
          await _webrtcManager?.addICECandidate(candidate);
          log('🧊 [ICE] Candidate flushed and added');
        }
        _iceCandidateBuffer.clear();
      }

      // If we received an offer (provider receives it), create answer
      if (sdp.type == 'offer' && _isProvider) {
        log('📤 [SESSION] Creating answer...');
        await _webrtcManager?.createAnswer();
      }
    } catch (e) {
      log('❌ [SESSION] Handle remote SDP failed: $e');
    }
  }

  /// Handle remote ICE candidate - WITH BUFFERING
  Future<void> _handleRemoteICE(IceCandidate ice) async {
    try {
      final rtcCandidate = RTCIceCandidate(
        ice.candidate,
        ice.sdpMid,
        ice.sdpMLineIndex,
      );
      
      if (!_remoteDescriptionSet) {
        log('🧊 [ICE] Buffering candidate (remote description not set yet)');
        _iceCandidateBuffer.add(rtcCandidate);
      } else {
        log('🧊 [ICE] Adding candidate immediately');
        await _webrtcManager?.addICECandidate(rtcCandidate);
      }
    } catch (e) {
      log('❌ [SESSION] Handle remote ICE failed: $e');
    }
  }

  /// Handle call end signal - BIDIRECTIONAL END
  void _handleCallEnd(EndCall end) {
    log('📞 [CALL] Remote end received - Reason: ${end.reason}');
    
    // Force end and notify UI to exit
    _forceEndCall('peer_ended: ${end.reason}');
  }

  /// Callback: Local SDP created (offer or answer)
  void _handleLocalSDP(RTCSessionDescription sdp) {
    log('📤 [SESSION] Sending local SDP - Type: ${sdp.type}');

    if (_signalingRequestController != null && !_signalingRequestController!.isClosed) {
      final event = ConnectionEvent(
        callId: _currentSessionId ?? '',
        senderId: _myUserId ?? '',
        receiverId: _peerUserId ?? '',
        sdp: SessionDescription(
          type: sdp.type ?? '',
          sdp: sdp.sdp ?? '',
        ),
      );
      
      _signalingRequestController!.add(event);
      log('✅ [SESSION] SDP sent via gRPC');
    }
  }

  /// Callback: ICE candidate generated
  void _handleICECandidate(RTCIceCandidate candidate) {
    if (candidate.candidate == null) return;

    log('📤 [SESSION] Sending ICE candidate');

    if (_signalingRequestController != null && !_signalingRequestController!.isClosed) {
      final event = ConnectionEvent(
        callId: _currentSessionId ?? '',
        senderId: _myUserId ?? '',
        receiverId: _peerUserId ?? '',
        ice: IceCandidate(
          candidate: candidate.candidate!,
          sdpMid: candidate.sdpMid ?? '',
          sdpMLineIndex: candidate.sdpMLineIndex ?? 0,
        ),
      );
      
      _signalingRequestController!.add(event);
    }
  }

  /// Callback: Remote stream arrived
  void _handleRemoteStream(MediaStream stream) {
    log('📺 [WEBRTC] Remote track received - Stream ID: ${stream.id}');
    log('📺 [WEBRTC] Remote stream - Video tracks: ${stream.getVideoTracks().length}, Audio: ${stream.getAudioTracks().length}');
    
    _remoteStreamController.add(stream);
    log('✅ [SESSION] Remote stream forwarded to UI');
  }

  /// Callback: Connection state changed - WITH NETWORK MONITORING
  void _handleConnectionStateChange(RTCPeerConnectionState state) {
    log('🔄 [PC] ConnectionState = $state');
    
    if (state == RTCPeerConnectionState.RTCPeerConnectionStateFailed) {
      log('❌ [PC] Connection FAILED - forcing call end');
      _forceEndCall('webrtc_failed');
    } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
      log('🚪 [PC] Connection CLOSED - forcing call end');
      _forceEndCall('webrtc_closed');
    } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected) {
      log('⚠️ [PC] Connection DISCONNECTED - Network may be unstable');
      // Don't force end immediately, give a chance to recover
    } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
      log('✅ [PC] Connection ESTABLISHED successfully!');
    }
  }

  @override
  Future<void> endSession() async {
    if (_currentSessionId == null || !_sessionActive) {
      log('✅ [SESSION] Already ended or never started');
      return;
    }
    
    log('🛑 [SESSION] Ending session: $_currentSessionId');
    _sessionActive = false; // Mark as inactive FIRST

    // Send End signal only if stream is open
    if (_signalingRequestController != null && !_signalingRequestController!.isClosed) {
      try {
        final endEvent = ConnectionEvent(
          callId: _currentSessionId!,
          senderId: _myUserId ?? '',
          receiverId: _peerUserId ?? '',
          end: EndCall(reason: 'Session ended'),
        );
        _signalingRequestController!.add(endEvent);
        log('📤 [SESSION] End signal sent to peer');
      } catch (e) {
        log('⚠️ [SESSION] Failed to send end signal: $e');
      }
    }

    // Cleanup WebRTC
    _webrtcManager?.dispose();
    _webrtcManager = null;
    log('✅ [WEBRTC] PeerConnection disposed');

    // Close signaling
    await _signalingSubscription?.cancel();
    await _signalingRequestController?.close();
    _signalingRequestController = null;
    _signalingSubscription = null;
    log('✅ [SESSION] StreamConnection closed');

    // Reset all state
    _currentSessionId = null;
    _myUserId = null;
    _peerUserId = null;
    _remoteDescriptionSet = false;
    _iceCandidateBuffer.clear();

    log('✅ [SESSION] Session ended and cleaned up');
  }

  @override
  Future<void> rotateCamera() async {
    log('🔄 [SESSION] Rotating camera...');
    await _webrtcManager?.switchCamera();
  }

  @override
  Future<void> toggleMute() async {
    log('🎤 [SESSION] Toggling mute...');
    _webrtcManager?.toggleMute();
  }

  @override
  Future<void> applyZoom(double delta) async {
    log('🔎 [SESSION] Applying zoom delta: $delta');
    await _webrtcManager?.applyZoom(delta);
  }

  @override
  Future<void> setZoomLevel(double level) async {
    log('🔎 [SESSION] Setting zoom level: $level');
    await _webrtcManager?.setZoomLevel(level);
  }

  @override
  Future<void> sendGestureCommand(Map<String, dynamic> command) async {
    log('🎮 [SESSION] Sending gesture command: $command');
    // TODO: Use ControlService.StreamControl for gestures
    // For now, add to events stream
    _sessionEventsController.add(command);
  }
}
