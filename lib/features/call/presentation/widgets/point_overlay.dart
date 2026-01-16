import 'package:flutter/material.dart';

/// Displays a persistent red dot at normalized coordinates on the provider's screen
/// Used for POINT_OBJECT commands from consumer
class PointOverlay extends StatelessWidget {
  final double x; // Normalized 0.0-1.0
  final double y; // Normalized 0.0-1.0
  final Size videoSize;

  const PointOverlay({
    required this.x,
    required this.y,
    required this.videoSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Convert normalized coords to actual position
    final left = (x * videoSize.width) - 10; // Center the 20px dot
    final top = (y * videoSize.height) - 10;

    return Positioned(
      left: left.clamp(0, videoSize.width - 20),
      top: top.clamp(0, videoSize.height - 20),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.6),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
