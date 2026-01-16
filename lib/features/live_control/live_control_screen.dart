import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:xeniqclone/src/generated/xeniq.pb.dart';
import 'package:xeniqclone/core/services/grpc/live_control_service.dart';

class LiveControlScreen extends StatefulWidget {
  final String callId;
  final bool isConsumer;
  final String serverIp;

  const LiveControlScreen({
    Key? key,
    required this.callId,
    required this.isConsumer,
    required this.serverIp,
  }) : super(key: key);

  @override
  _LiveControlScreenState createState() => _LiveControlScreenState();
}

class _LiveControlScreenState extends State<LiveControlScreen> {
  late LiveControlService _service;
  Stream<ControlEvent>? _incomingStream;
  String _lastStatus = "Disconnected";
  
  // Gyro
  double _pitch = 0;
  double _roll = 0;
  double _yaw = 0;

  @override
  void initState() {
    super.initState();
    // LiveControlService now uses BackendConfig automatically
    _service = LiveControlService();
    _connect();
  }

  Future<void> _connect() async {
    try {
      setState(() => _lastStatus = "Connecting...");
      
      // New API: pass bool isProvider (false for consumer)
      final isProvider = !widget.isConsumer;
      _incomingStream = await _service.startSession(widget.callId, isProvider);
      
      setState(() => _lastStatus = "Connected as ${widget.isConsumer ? 'Consumer' : 'Provider'}");

      if (widget.isConsumer) {
        // Start listening to sensors if consumer
        // Note: sendGyro is not supported in new API, gyro data ignored
        gyroscopeEventStream().listen((GyroscopeEvent event) {
          setState(() {
            _pitch = event.x;
            _roll = event.y;
            _yaw = event.z;
          });
        });
      }
    } catch (e) {
      setState(() => _lastStatus = "Error: $e");
    }
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Control: ${widget.callId}")),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black12,
            child: Text("Status: $_lastStatus"),
          ),
          
          if (widget.isConsumer) _buildConsumerControls(),
          if (!widget.isConsumer) _buildProviderView(),
          
          Expanded(
            child: StreamBuilder<ControlEvent>(
              stream: _incomingStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: Text("Waiting for events..."));
                final event = snapshot.data!;
                return ListView(
                  children: [
                    ListTile(
                      title: Text("Received Event from ${event.senderId}"),
                      subtitle: Text(event.toString()),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsumerControls() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text("GYRO DATA (Display Only)", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("X: ${_pitch.toStringAsFixed(2)} Y: ${_roll.toStringAsFixed(2)} Z: ${_yaw.toStringAsFixed(2)}"),
        const Divider(),
        Wrap(
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () => _service.sendCommand(widget.callId, CommandType.ROTATE_LEFT),
              child: const Text("LEFT"),
            ),
            ElevatedButton(
              onPressed: () => _service.sendCommand(widget.callId, CommandType.ROTATE_RIGHT),
              child: const Text("RIGHT"),
            ),
            ElevatedButton(
              onPressed: () => _service.sendCommand(widget.callId, CommandType.MOVE_FORWARD),
              child: const Text("FORWARD"),
            ),
            ElevatedButton(
              onPressed: () => _service.sendCommand(widget.callId, CommandType.STOP),
              child: const Text("STOP"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProviderView() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(child: Text("Provider Mode: Waiting for commands (check log below)")),
    );
  }
}
