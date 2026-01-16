import 'dart:async';
import 'dart:developer';
import 'package:xeniqclone/services/grpc_service.dart';
import 'package:xeniqclone/src/generated/xeniq.pb.dart';

/// Singleton service managing provider's incoming call stream
/// Connects to backend StreamIncomingCalls RPC and exposes events
class IncomingCallListenerService {
  static final IncomingCallListenerService _instance = IncomingCallListenerService._internal();
  factory IncomingCallListenerService() => _instance;
  IncomingCallListenerService._internal();

  StreamSubscription<IncomingCallEvent>? _subscription;
  final _controller = StreamController<IncomingCallEvent>.broadcast();
  String? _currentProviderId;
  bool _isListening = false;

  /// Stream of incoming call events for UI consumption
  Stream<IncomingCallEvent> get onIncomingCall => _controller.stream;

  /// Check if currently listening
  bool get isListening => _isListening;

  /// Start listening for incoming calls for the given provider
  /// Only one stream per provider - calling again with same ID is a no-op
  void startListening(String providerId) {
    if (_isListening && _currentProviderId == providerId) {
      log('📡 [INCOMING_CALLS] Already listening for provider: $providerId');
      return;
    }

    // Stop any existing stream first
    if (_isListening) {
      log('📡 [INCOMING_CALLS] Stopping previous stream before starting new one');
      stopListening();
    }

    log('📡 [INCOMING_CALLS] Starting stream for provider: $providerId');

    try {
      final request = IncomingCallsRequest(providerId: providerId);
      final stream = GrpcService().connectClient.streamIncomingCalls(request);

      _subscription = stream.listen(
        (event) {
          log('🔔 [INCOMING_CALLS] Received call: ${event.callId} from ${event.consumerName}');
          _controller.add(event);
        },
        onError: (error) {
          log('❌ [INCOMING_CALLS] Stream error: $error');
          // Don't crash - just log the error
          _isListening = false;
          _currentProviderId = null;
        },
        onDone: () {
          log('📡 [INCOMING_CALLS] Stream closed');
          _isListening = false;
          _currentProviderId = null;
        },
      );

      _isListening = true;
      _currentProviderId = providerId;
      log('✅ [INCOMING_CALLS] Stream active for provider: $providerId');
    } catch (e) {
      log('❌ [INCOMING_CALLS] Failed to start stream: $e');
      _isListening = false;
      _currentProviderId = null;
    }
  }

  /// Stop listening to incoming calls
  void stopListening() {
    if (!_isListening) {
      log('📡 [INCOMING_CALLS] Not currently listening, nothing to stop');
      return;
    }

    log('📡 [INCOMING_CALLS] Stopping stream for provider: $_currentProviderId');
    
    _subscription?.cancel();
    _subscription = null;
    _isListening = false;
    _currentProviderId = null;

    log('✅ [INCOMING_CALLS] Stream stopped');
  }

  /// Cleanup - call this when service is no longer needed
  void dispose() {
    stopListening();
    _controller.close();
  }
}
