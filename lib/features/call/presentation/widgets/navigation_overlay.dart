import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xeniqclone/core/services/grpc/livecontrol.pb.dart';

/// Navigation overlay for consumer to control provider's camera/movement
/// Only visible when: isProvider = false && call is connected
class NavigationOverlay extends StatefulWidget {
  final Function(CommandType type, {double? x, double? y, double? zoomDelta}) onCommand;
  final Size videoSize;

  const NavigationOverlay({
    required this.onCommand,
    required this.videoSize,
    super.key,
  });

  @override
  State<NavigationOverlay> createState() => _NavigationOverlayState();
}

class _NavigationOverlayState extends State<NavigationOverlay> {
  double _lastScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gesture detection layer (full screen for tap-to-point and pinch zoom)
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onScaleStart: (details) {
              _lastScale = 1.0;
            },
            onScaleUpdate: _handlePinchZoom,
            onTapUp: _handleTap,
            child: Container(color: Colors.transparent),
          ),
        ),

        // Navigation buttons (bottom 30%)
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.only(bottom: 24, top: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Movement controls - D-pad style
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNavButton(Icons.arrow_upward, CommandType.MOVE_FORWARD, 'Forward'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNavButton(Icons.arrow_back, CommandType.ROTATE_LEFT, 'Left'),
                    const SizedBox(width: 60),
                    _buildNavButton(Icons.arrow_forward, CommandType.ROTATE_RIGHT, 'Right'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNavButton(Icons.arrow_downward, CommandType.MOVE_BACKWARD, 'Back'),
                  ],
                ),

                const SizedBox(height: 20),

                // Zoom controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNavButton(Icons.remove_circle_outline, CommandType.ZOOM_OUT, 'Zoom Out'),
                    const SizedBox(width: 40),
                    _buildNavButton(Icons.add_circle_outline, CommandType.ZOOM_IN, 'Zoom In'),
                  ],
                ),

                const SizedBox(height: 8),
                
                // Hint text
                Text(
                  'Tap video to point • Pinch to zoom',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavButton(IconData icon, CommandType type, String label) {
    return Tooltip(
      message: label,
      child: Material(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          onTap: () => _sendCommand(type),
          borderRadius: BorderRadius.circular(28),
          child: Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }

  void _sendCommand(CommandType type, {double? x, double? y, double? zoomDelta}) {
    HapticFeedback.lightImpact();
    widget.onCommand(type, x: x, y: y, zoomDelta: zoomDelta);
  }

  void _handlePinchZoom(ScaleUpdateDetails details) {
    final scaleDelta = details.scale - _lastScale;
    _lastScale = details.scale;

    // Only send if significant change
    if (scaleDelta.abs() > 0.02) {
      _sendCommand(
        CommandType.ZOOM_DELTA,
        zoomDelta: scaleDelta * 0.5, // Sensitivity adjustment
      );
    }
  }

  void _handleTap(TapUpDetails details) {
    // Calculate normalized coordinates (0.0-1.0)
    final x = details.localPosition.dx / widget.videoSize.width;
    final y = details.localPosition.dy / widget.videoSize.height;

    // Clamp to valid range
    final clampedX = x.clamp(0.0, 1.0);
    final clampedY = y.clamp(0.0, 1.0);

    _sendCommand(CommandType.POINT_OBJECT, x: clampedX, y: clampedY);
  }
}
