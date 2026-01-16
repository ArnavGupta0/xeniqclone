import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  final String callId;
  final String otherUserId;
  final bool isCaller;

  const CallScreen({
    super.key,
    required this.callId,
    required this.otherUserId,
    this.isCaller = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1115),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Icon(Icons.call, size: 80, color: Colors.green),
             const SizedBox(height: 20),
             Text(
               isCaller ? 'Calling...' : 'In Call',
               style: const TextStyle(color: Colors.white, fontSize: 24),
             ),
             const SizedBox(height: 40),
             ElevatedButton(
               style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
               onPressed: () => Navigator.pop(context),
               child: const Text('End Call', style: TextStyle(color: Colors.white)),
             ),
          ],
        ),
      ),
    );
  }
}
