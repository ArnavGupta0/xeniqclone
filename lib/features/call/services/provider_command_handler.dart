import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xeniqclone/core/services/grpc/livecontrol.pb.dart';

/// Handles execution of navigation commands received from consumer
/// Shows visual feedback and applies camera controls on provider side
class ProviderCommandHandler {
  final Function(Widget overlay, Duration duration) showTemporaryOverlay;
  final Function(double x, double y) showPointAt;
  final Function() clearPoint;

  ProviderCommandHandler({
    required this.showTemporaryOverlay,
    required this.showPointAt,
    required this.clearPoint,
  });

  /// Execute a navigation command received from consumer
  void executeCommand(CommandEvent command) {
    switch (command.type) {
      case CommandType.MOVE_FORWARD:
        _showDirectionHint('↑', Colors.blue);
        break;

      case CommandType.MOVE_BACKWARD:
        _showDirectionHint('↓', Colors.blue);
        break;

      case CommandType.ROTATE_LEFT:
        _showDirectionHint('←', Colors.green);
        break;

      case CommandType.ROTATE_RIGHT:
        _showDirectionHint('→', Colors.green);
        break;

      case CommandType.ZOOM_IN:
        _showZoomHint('+', 'Zoom In');
        break;

      case CommandType.ZOOM_OUT:
        _showZoomHint('-', 'Zoom Out');
        break;

      case CommandType.ZOOM_DELTA:
        // For pinch gestures - show subtle indicator
        final delta = command.zoomDelta;
        if (delta.abs() > 0.05) {
          _showZoomHint(delta > 0 ? '+' : '-', 'Zooming...');
        }
        break;

      case CommandType.POINT_OBJECT:
        // Show point at normalized coordinates
        showPointAt(command.x, command.y);
        break;

      case CommandType.STOP:
        _showDirectionHint('⏹', Colors.red);
        break;

      default:
        debugPrint('Unknown command type: ${command.type}');
    }
  }

  void _showDirectionHint(String arrow, Color color) {
    showTemporaryOverlay(
      Center(
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
      ),
      const Duration(milliseconds: 500),
    );

    HapticFeedback.mediumImpact();
  }

  void _showZoomHint(String symbol, String label) {
    showTemporaryOverlay(
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                symbol == '+' ? Icons.zoom_in : Icons.zoom_out,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      const Duration(milliseconds: 400),
    );

    HapticFeedback.lightImpact();
  }
}
