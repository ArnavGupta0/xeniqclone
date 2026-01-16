import 'package:flutter/material.dart';
import 'package:xeniqclone/features/session/presentation/screens/call_screen.dart' as session;
import 'package:xeniqclone/features/call/services/call_request_service.dart';

class IncomingCallDialog extends StatelessWidget {
  final String callId;
  final String callerName;
  final String senderId;
  final String providerId; // Provider's actual user ID

  const IncomingCallDialog({
    super.key,
    required this.callId,
    required this.callerName,
    required this.senderId,
    required this.providerId,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F2E),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 30,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: Color(0xFF3B82F6),
                    size: 48,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Incoming Call',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  callerName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 _buildActionButton(
                  context,
                  icon: Icons.call_end_rounded,
                  color: const Color(0xFFEF4444),
                  label: 'Decline',
                  onTap: () async {
                    // Decline the call on backend
                    await CallRequestService().declineCall(
                      callId: callId,
                      providerId: providerId,
                      reason: 'User declined',
                    );
                    
                    if (!context.mounted) return;
                    
                    // Close dialog
                    Navigator.pop(context);
                  },
                ),
                _buildActionButton(
                  context,
                  icon: Icons.call_rounded,
                  color: const Color(0xFF22C55E),
                  label: 'Accept',
                  onTap: () async {
                    final response = await CallRequestService().acceptCall(
                      callId: callId,
                      providerId: providerId,
                    );
                    
                    if (!context.mounted) return;
                    
                    Navigator.pop(context); // Close Dialog
                    
                    if (response.success && response.sessionId.isNotEmpty) {
                      // Navigate to session CallScreen with sessionId from backend
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => session.CallScreen(
                            sessionId: response.sessionId,
                            isProvider: true,
                          ),
                        ),
                      );
                    } else {
                      // Show error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to accept call')),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
