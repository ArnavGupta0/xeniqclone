import 'dart:async';
import 'dart:developer';
import 'package:flutter_webrtc/flutter_webrtc.dart';

/// WebRTC Manager - Handles PeerConnection lifecycle, media capture, and signaling
/// 
/// Responsibilities:
/// - Create and manage RTCPeerConnection
/// - Capture local media (camera + microphone)
/// - Handle remote stream arrival
/// - Generate and handle ICE candidates
/// - Create SDP offers/answers
/// - Connection state management
class WebRTCManager {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  
  // Callbacks for signaling
  final Function(RTCSessionDescription sdp)? onLocalSDP;
  final Function(RTCIceCandidate candidate)? onICECandidate;
  final Function(MediaStream stream)? onRemoteStream;
  final Function(RTCPeerConnectionState state)? onConnectionStateChange;
  
  // State
  bool _isInitialized = false;
  bool _isDisposed = false;
  
  WebRTCManager({
    this.onLocalSDP,
    this.onICECandidate,
    this.onRemoteStream,
    this.onConnectionStateChange,
  });

  /// Initialize WebRTC with media capture
  /// 
  /// [isInitiator] - true if this peer creates the offer (consumer)
  /// [isProvider] - true for provider (rear camera), false for consumer (front camera)
  Future<void> init({required bool isInitiator, required bool isProvider}) async {
    if (_isInitialized) {
      log('⚠️ [WEBRTC] Already initialized');
      return;
    }

    try {
      log('🎥 [WEBRTC] Initializing - Initiator: $isInitiator, Provider: $isProvider');

      // 1. Create peer connection
      await _createPeerConnection();

      // 2. Capture local media
      await _captureLocalMedia(isProvider: isProvider);

      // 3. Add local tracks to peer connection
      if (_localStream != null) {
        _localStream!.getTracks().forEach((track) {
          log('➕ [WEBRTC] Adding local track: ${track.kind}');
          _peerConnection!.addTrack(track, _localStream!);
        });
      }
      
      // 4. Add transceivers for RECEIVING video (critical for consumer)
      if (!isProvider) {
        log('📡 [WEBRTC] Consumer: Adding video transceiver for RECEIVING');
        await _peerConnection!.addTransceiver(
          kind: RTCRtpMediaType.RTCRtpMediaTypeVideo,
          init: RTCRtpTransceiverInit(direction: TransceiverDirection.RecvOnly),
        );
        log('✅ [WEBRTC] Consumer transceiver added - ready to receive video  ');
      }

      _isInitialized = true;
      log('✅ [WEBRTC] Initialization complete');
    } catch (e) {
      log('❌ [WEBRTC] Initialization failed: $e');
      rethrow;
    }
  }

  /// Create RTCPeerConnection with STUN servers
  Future<void> _createPeerConnection() async {
    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        {'urls': 'stun:stun1.l.google.com:19302'},
      ],
      'sdpSemantics': 'unified-plan',
    };

    _peerConnection = await createPeerConnection(configuration);
    log('🔗 [WEBRTC] PeerConnection created');

    // Set up event handlers
    _peerConnection!.onIceCandidate = (candidate) {
      log('🧊 [WEBRTC] ICE Candidate generated: ${candidate.candidate?.substring(0, 50)}...');
      onICECandidate?.call(candidate);
    };

    _peerConnection!.onTrack = (event) {
      log('📺 [WEBRTC] ========== REMOTE TRACK RECEIVED ==========');
      log('📺 [WEBRTC] Track kind: ${event.track.kind}');
      log('📺 [WEBRTC] Track ID: ${event.track.id}');
      log('📺 [WEBRTC] Track enabled: ${event.track.enabled}');
      log('📺 [WEBRTC] Number of streams: ${event.streams.length}');
      
      if (event.streams.isNotEmpty) {
        final stream = event.streams.first;
        log('✅ [WEBRTC] Remote stream ID: ${stream.id}');
        log('✅ [WEBRTC] Remote stream - Video tracks: ${stream.getVideoTracks().length}, Audio: ${stream.getAudioTracks().length}');
        log('📺 [WEBRTC] ===========================================');
        onRemoteStream?.call(stream);
      } else {
        log('⚠️ [WEBRTC] Track received but NO streams attached!');
      }
    };

    _peerConnection!.onConnectionState = (state) {
      log('🔄 [WEBRTC] Connection state: $state');
      onConnectionStateChange?.call(state);
    };

    _peerConnection!.onIceConnectionState = (state) {
      log('🧊 [WEBRTC] ICE connection state: $state');
    };

    _peerConnection!.onSignalingState = (state) {
      log('📡 [WEBRTC] Signaling state: $state');
    };
  }

  /// Capture local media (camera only - NO AUDIO)
  Future<void> _captureLocalMedia({required bool isProvider}) async {
    try {
      final constraints = {
        'audio': false, // ❌ NO AUDIO - Video only
        'video': {
          'facingMode': isProvider ? 'environment' : 'user', // Rear for provider, front for consumer
          'width': {'ideal': 1280},
          'height': {'ideal': 720},
        },
      };

      log('📸 [WEBRTC] Capturing media - Camera: ${isProvider ? "rear" : "front"}, Audio: DISABLED');
      _localStream = await navigator.mediaDevices.getUserMedia(constraints);
      
      final videoTracks = _localStream!.getVideoTracks();
      final audioTracks = _localStream!.getAudioTracks();
      
      log('✅ [WEBRTC] Media captured - Video: ${videoTracks.length}, Audio: ${audioTracks.length}');
    } catch (e) {
      log('❌ [WEBRTC] Media capture failed: $e');
      rethrow;
    }
  }

  /// Create SDP offer (consumer initiates)
  Future<void> createOffer() async {
    if (_peerConnection == null) {
      throw StateError('PeerConnection not initialized');
    }

    try {
      log('📤 [WEBRTC] Consumer creating offer...');
      
      // Use modern constraints (unified-plan handles transceivers)
      final offer = await _peerConnection!.createOffer();
      
      await _peerConnection!.setLocalDescription(offer);
      log('✅ [WEBRTC] Consumer: Offer created and set as local description');
      log('📋 [WEBRTC] SDP Offer type: ${offer.type}, length: ${offer.sdp?.length ?? 0} chars');
      
      onLocalSDP?.call(offer);
    } catch (e) {
      log('❌ [WEBRTC] Create offer failed: $e');
      rethrow;
    }
  }

  /// Create SDP answer (provider responds)
  Future<void> createAnswer() async {
    if (_peerConnection == null) {
      throw StateError('PeerConnection not initialized');
    }

    try {
      log('📤 [WEBRTC] Provider creating answer...');
      
      final answer = await _peerConnection!.createAnswer();
      
      await _peerConnection!.setLocalDescription(answer);
      log('✅ [WEBRTC] Provider: Answer created and set as local description');
      log('📋 [WEBRTC] SDP Answer type: ${answer.type}, length: ${answer.sdp?.length ?? 0} chars');
      
      onLocalSDP?.call(answer);
    } catch (e) {
      log('❌ [WEBRTC] Create answer failed: $e');
      rethrow;
    }
  }

  /// Set remote SDP description (offer or answer from peer)
  Future<void> setRemoteDescription(RTCSessionDescription sdp) async {
    if (_peerConnection == null) {
      throw StateError('PeerConnection not initialized');
    }

    try {
      log('📋 [WEBRTC] Setting remote description - Type: ${sdp.type}');
      await _peerConnection!.setRemoteDescription(sdp);
      log('✅ [WEBRTC] Remote description set successfully');
      log('📊 [WEBRTC] Signaling state after setRemote: ${_peerConnection!.signalingState}');
    } catch (e) {
      log('❌ [WEBRTC] Set remote description failed: $e');
      rethrow;
    }
  }

  /// Add ICE candidate from peer
  Future<void> addICECandidate(RTCIceCandidate candidate) async {
    if (_peerConnection == null) {
      throw StateError('PeerConnection not initialized');
    }

    try {
      log('🧊 [WEBRTC] Adding ICE candidate: ${candidate.candidate?.substring(0, 50)}...');
      await _peerConnection!.addCandidate(candidate);
      log('✅ [WEBRTC] ICE candidate added');
    } catch (e) {
      log('❌ [WEBRTC] Add ICE candidate failed: $e');
      // Don't rethrow - ICE candidates can fail and that's okay
    }
  }

  /// Toggle microphone mute/unmute
  void toggleMute() {
    if (_localStream != null) {
      final audioTracks = _localStream!.getAudioTracks();
      if (audioTracks.isNotEmpty) {
        final track = audioTracks.first;
        track.enabled = !track.enabled;
        log('🎤 [WEBRTC] Microphone ${track.enabled ? "unmuted" : "muted"}');
      }
    }
  }

  /// Switch camera (provider only - front/back)
  Future<void> switchCamera() async {
    if (_localStream != null) {
      final videoTracks = _localStream!.getVideoTracks();
      if (videoTracks.isNotEmpty) {
        try {
          log('🔄 [WEBRTC] Switching camera...');
          await Helper.switchCamera(videoTracks.first);
          log('✅ [WEBRTC] Camera switched');
        } catch (e) {
          log('❌ [WEBRTC] Camera switch failed: $e');
        }
      }
    }
  }

  // Current zoom level (between 1.0 and max supported)
  double _currentZoom = 1.0;
  static const double _minZoom = 1.0;
  static const double _maxZoom = 10.0; // Most devices support up to 10x

  /// Apply zoom delta to camera (provider only)
  /// delta > 0 = zoom in, delta < 0 = zoom out
  Future<void> applyZoom(double delta) async {
    if (_localStream == null) return;

    final videoTracks = _localStream!.getVideoTracks();
    if (videoTracks.isEmpty) return;

    final track = videoTracks.first;

    try {
      // Calculate new zoom level
      final newZoom = (_currentZoom + delta).clamp(_minZoom, _maxZoom);

      if ((newZoom - _currentZoom).abs() < 0.001) {
        return; // No meaningful change
      }

      // Use Helper.setZoom - the correct flutter_webrtc API
      await Helper.setZoom(track, newZoom);

      _currentZoom = newZoom;
      log('🔎 [ZOOM] Applied zoom: ${newZoom.toStringAsFixed(2)} (delta: ${delta.toStringAsFixed(3)})');
    } catch (e) {
      log('⚠️ [ZOOM] Zoom not supported or failed: $e');
      // Don't crash - just log and ignore
    }
  }

  /// Get local media stream
  MediaStream? get localStream => _localStream;

  /// Clean up resources
  void dispose() {
    if (_isDisposed) return;

    log('🧹 [WEBRTC] Disposing resources...');

    _localStream?.getTracks().forEach((track) {
      track.stop();
    });
    _localStream?.dispose();
    _localStream = null;

    _peerConnection?.close();
    _peerConnection?.dispose();
    _peerConnection = null;

    _isInitialized = false;
    _isDisposed = true;

    log('✅ [WEBRTC] Cleanup complete');
  }
}
