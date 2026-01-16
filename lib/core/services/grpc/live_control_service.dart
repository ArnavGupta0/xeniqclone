import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:xeniqclone/core/config/backend_config.dart';
// Use xeniq proto - it has the correct ControlEvent structure with senderId
import 'package:xeniqclone/src/generated/xeniq.pbgrpc.dart';
import 'package:xeniqclone/src/generated/xeniq.pb.dart';

class LiveControlService {
  late ClientChannel _channel;
  late ControlServiceClient _client;
  
  // Stream controller to push messages TO the server
  StreamController<ControlEvent>? _outputController;
  
  // Stream response FROM the server
  ResponseStream<ControlEvent>? _responseStream;

  // Track if connected
  bool _isConnected = false;

  // Use BackendConfig for ALL connections
  String get host => BackendConfig.backendHost;
  int get port => BackendConfig.backendPort;

  LiveControlService() {
    debugPrint('📡 [CONTROL] Creating channel → $host:$port');
    
    _channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _client = ControlServiceClient(_channel);
    
    debugPrint('✅ [CONTROL] Channel created');
  }

  /// Start control stream session
  /// Returns the stream of events coming FROM the server
  Future<Stream<ControlEvent>> startSession(String callId, bool isProvider) async {
    _outputController = StreamController<ControlEvent>();
    
    // Create bidirectional stream
    _responseStream = _client.streamControl(_outputController!.stream);

    // Determine sender ID with proper prefix for backend role detection
    final senderId = isProvider ? 'provider-$callId' : 'consumer-$callId';

    debugPrint('🎮 [CONTROL] Sending handshake: call=$callId sender=$senderId');

    // Send handshake message with proper senderId
    _outputController!.add(ControlEvent(
      callId: callId,
      senderId: senderId,
      // No command in handshake - just identity
    ));

    _isConnected = true;
    debugPrint('✅ [CONTROL] Handshake sent, stream active');

    return _responseStream!;
  }

  void sendCommand(String callId, CommandType type, {double value = 0.0}) {
    if (_outputController == null || _outputController!.isClosed) {
      debugPrint('❌ [CONTROL] Cannot send command - stream not open');
      return;
    }
    
    debugPrint('📤 [CONTROL] Sending command: $type (call=$callId)');
    
    _outputController!.add(ControlEvent(
      callId: callId,
      senderId: 'consumer-$callId', // Consumer sends commands
      command: CameraCommand(
        type: type,
        value: value,
      ),
    ));
  }

  /// Send zoom in command
  void sendZoomIn(String callId) {
    sendCommand(callId, CommandType.ZOOM_IN);
  }

  /// Send zoom out command
  void sendZoomOut(String callId) {
    sendCommand(callId, CommandType.ZOOM_OUT);
  }

  /// Send zoom delta command (for slider)
  /// Uses ZOOM_IN type with value field for delta amount
  void sendZoomDelta(String callId, double delta) {
    if (_outputController == null || _outputController!.isClosed) {
      debugPrint('❌ [CONTROL] Cannot send command - stream not open');
      return;
    }
    
    // Use ZOOM_IN for positive delta, ZOOM_OUT for negative
    final type = delta >= 0 ? CommandType.ZOOM_IN : CommandType.ZOOM_OUT;
    
    debugPrint('📤 [CONTROL] Sending zoom delta: $delta (type=$type)');
    
    _outputController!.add(ControlEvent(
      callId: callId,
      senderId: 'consumer-$callId',
      command: CameraCommand(
        type: type,
        value: delta.abs(), // Store absolute delta in value field
      ),
    ));
  }

  /// Send point to object command with normalized coordinates
  void sendPointObject(String callId, double x, double y) {
    if (_outputController == null || _outputController!.isClosed) {
      debugPrint('❌ [CONTROL] Cannot send command - stream not open');
      return;
    }
    
    debugPrint('📤 [CONTROL] Sending POINT_TO_OBJECT: ($x, $y)');
    
    _outputController!.add(ControlEvent(
      callId: callId,
      senderId: 'consumer-$callId',
      command: CameraCommand(
        type: CommandType.POINT_TO_OBJECT,
        value: x, // encode x in value, or use separate mechanism
      ),
    ));
  }

  Future<void> dispose() async {
    debugPrint('🗑️ [CONTROL] Disposing control service');
    _isConnected = false;
    await _outputController?.close();
    await _channel.shutdown();
  }
}
