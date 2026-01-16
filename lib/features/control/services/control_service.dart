import 'dart:async';
import 'dart:developer';

import 'package:xeniqclone/services/grpc_service.dart';
import 'package:xeniqclone/src/generated/xeniq.pb.dart';
import 'package:xeniqclone/src/generated/xeniq.pbgrpc.dart';

class ControlService {
  static final ControlService _instance = ControlService._internal();
  factory ControlService() => _instance;

  final ControlServiceClient _client = GrpcService().controlClient;
  
  StreamController<ControlEvent>? _eventController;
  StreamSubscription<ControlEvent>? _grpcSubscription;
  StreamController<ControlEvent>? _outboundController;

  Stream<ControlEvent> get onEvent => _eventController!.stream;

  ControlService._internal() {
    _eventController = StreamController<ControlEvent>.broadcast(
      onListen: _connect,
      onCancel: _disconnect,
    );
  }

  void _connect() {
    // Lazy connection or manual? For now, we wait for startSession
  }
  
  Future<void> startSession(String callId, String senderId) async {
    if (_grpcSubscription != null) return;
    
    log('Starting Control Session: $callId');
    
    final requestController = StreamController<ControlEvent>();
    _outboundController = requestController;

    try {
      final responseStream = _client.streamControl(requestController.stream);
      
      _grpcSubscription = responseStream.listen(
        (event) {
          // Log or process incoming commands (if we are Provider) or Acks (if Consumer)
          _eventController?.add(event);
        },
        onError: (e) {
          log('Control Stream error: $e');
        },
        onDone: () {
          log('Control Stream closed');
        },
      );

      // Handshake / Register
      final initEvent = ControlEvent(
        callId: callId,
        senderId: senderId,
        // No payload needed for init, or maybe an Ack?
        // Server creates mapping on first message.
      );
      requestController.add(initEvent);
      
    } catch (e) {
      log('Failed to start control session: $e');
    }
  }

  void sendCommand(CommandType type, float value) {
     if (_outboundController == null) return;
     
     final event = ControlEvent(
       command: CameraCommand(
         type: type,
         value: value,
       ),
     );
     _outboundController!.add(event);
  }
  
  void sendGyro({required double x, required double y, required double z, required double roll, required double pitch, required double yaw}) {
    if (_outboundController == null) return;
    
    // Throttle? The UI/Sensor logic should throttle.
    final event = ControlEvent(
      gyro: GyroData(
        x: x, y: y, z: z,
        roll: roll, pitch: pitch, yaw: yaw,
      ),
    );
    _outboundController!.add(event);
  }

  void _disconnect() {
    _outboundController?.close();
    _grpcSubscription?.cancel();
    _grpcSubscription = null;
    _outboundController = null;
  }
}
