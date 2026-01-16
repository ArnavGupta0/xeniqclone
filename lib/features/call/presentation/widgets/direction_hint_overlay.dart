import 'package:flutter/material.dart';

/// Temporary overlay showing direction arrow (500ms duration)
/// Used for movement commands (MOVE_FORWARD, MOVE_BACKWARD, ROTATE_LEFT, ROTATE_RIGHT)
class DirectionHintOverlay extends StatelessWidget {
  final String arrow;
  final Color color;

  const DirectionHintOverlay({
    required this.arrow,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.5), width: 2),
        ),
        child: Text(
          arrow,
          style: TextStyle(
            fontSize: 64,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
