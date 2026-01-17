import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Displays gyroscope guidance overlay on provider's screen.
/// Shows a red dot indicating consumer's intent and directional arrows
/// to help provider understand how to move the camera.
///
/// Key behaviors:
/// - Dot shows where consumer wants provider to look
/// - Arrows tell provider which direction to move camera
/// - Dampened and smoothed for human-friendly UX
class GuidanceOverlay extends StatefulWidget {
  /// Consumer's normalized orientation (yaw, pitch) in range [-1, +1]
  /// yaw: negative = consumer tilted LEFT, positive = tilted RIGHT
  /// pitch: negative = consumer tilted DOWN, positive = tilted UP
  final Offset consumerDot;

  /// Provider's local device orientation (unused for now, reserved for future)
  final Offset providerDot;

  /// Whether to show alignment feedback (arrows fade when aligned)
  final bool showAlignmentFeedback;

  const GuidanceOverlay({
    required this.consumerDot,
    required this.providerDot,
    this.showAlignmentFeedback = true,
    super.key,
  });

  @override
  State<GuidanceOverlay> createState() => _GuidanceOverlayState();
}

class _GuidanceOverlayState extends State<GuidanceOverlay> {
  // EMA smoothing state
  double _smoothedYaw = 0.0;
  double _smoothedPitch = 0.0;

  // Dead zone threshold - larger for forgiving guidance
  static const double deadZone = 0.15;

  // EMA smoothing coefficient (0.25 = 25% new value, 75% previous for heavy smoothing)
  static const double smoothingAlpha = 0.25;

  // Post-smoothing gain reduction (applied AFTER smoothing to reduce oversensitivity)
  static const double postSmoothingGain = 0.45;

  // Max dot radius as fraction of screen (20% each direction from center)
  static const double maxRadiusFraction = 0.20;

  @override
  void didUpdateWidget(GuidanceOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Apply dampening and smoothing when new values arrive
    if (oldWidget.consumerDot != widget.consumerDot) {
      _updateSmoothedValues();
    }
  }

  void _updateSmoothedValues() {
    // Get raw values
    double rawYaw = widget.consumerDot.dx;
    double rawPitch = widget.consumerDot.dy;

    // CRITICAL: Fix direction inversion
    // Consumer tilts LEFT → yaw should be negative → arrow should point LEFT
    // We INVERT yaw to correct the observed reversal
    rawYaw = -rawYaw;

    // Apply EMA smoothing FIRST (heavy smoothing reduces jitter)
    _smoothedYaw = smoothingAlpha * rawYaw + (1 - smoothingAlpha) * _smoothedYaw;
    _smoothedPitch = smoothingAlpha * rawPitch + (1 - smoothingAlpha) * _smoothedPitch;
  }

  // Get display values with post-smoothing gain applied
  double get _displayYaw => _smoothedYaw * postSmoothingGain;
  double get _displayPitch => _smoothedPitch * postSmoothingGain;

  @override
  Widget build(BuildContext context) {
    // Ensure smoothing is applied on first build
    if (_smoothedYaw == 0.0 && _smoothedPitch == 0.0 && widget.consumerDot != Offset.zero) {
      _updateSmoothedValues();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        final center = Offset(size.width / 2, size.height / 2);

        // Clamp movement radius to 20% of screen dimensions
        final maxRadiusX = size.width * maxRadiusFraction;
        final maxRadiusY = size.height * maxRadiusFraction;

        // Map display coordinates (with gain applied) to screen position
        // yaw: negative = left, positive = right
        // pitch: positive = up (invert for screen Y which grows downward)
        final dotX = center.dx + (_displayYaw * maxRadiusX);
        final dotY = center.dy - (_displayPitch * maxRadiusY);

        // Arrow visibility derived from display values (with gain applied)
        final yaw = _displayYaw;
        final pitch = _displayPitch;

        // Arrow directions: show arrow in the direction provider should MOVE
        // If yaw > 0 (consumer wants to look RIGHT), show RIGHT arrow
        // If yaw < 0 (consumer wants to look LEFT), show LEFT arrow
        final showLeftArrow = yaw < -deadZone;
        final showRightArrow = yaw > deadZone;
        final showUpArrow = pitch > deadZone;
        final showDownArrow = pitch < -deadZone;

        // Calculate intensities (0.0 to 1.0) based on magnitude beyond dead zone
        final horizontalIntensity = ((yaw.abs() - deadZone) / (1.0 - deadZone)).clamp(0.0, 1.0);
        final verticalIntensity = ((pitch.abs() - deadZone) / (1.0 - deadZone)).clamp(0.0, 1.0);

        // Check if aligned (within dead zone)
        final isAligned = yaw.abs() < deadZone && pitch.abs() < deadZone;

        return Stack(
          children: [
            // Left Arrow (←) - provider should move camera LEFT
            if (showLeftArrow)
              _buildDirectionalArrow(
                icon: Icons.arrow_back_rounded,
                alignment: Alignment.centerLeft,
                intensity: horizontalIntensity,
                padding: const EdgeInsets.only(left: 20),
              ),

            // Right Arrow (→) - provider should move camera RIGHT
            if (showRightArrow)
              _buildDirectionalArrow(
                icon: Icons.arrow_forward_rounded,
                alignment: Alignment.centerRight,
                intensity: horizontalIntensity,
                padding: const EdgeInsets.only(right: 20),
              ),

            // Up Arrow (↑) - provider should move camera UP
            if (showUpArrow)
              _buildDirectionalArrow(
                icon: Icons.arrow_upward_rounded,
                alignment: Alignment.topCenter,
                intensity: verticalIntensity,
                padding: const EdgeInsets.only(top: 80),
              ),

            // Down Arrow (↓) - provider should move camera DOWN
            if (showDownArrow)
              _buildDirectionalArrow(
                icon: Icons.arrow_downward_rounded,
                alignment: Alignment.bottomCenter,
                intensity: verticalIntensity,
                padding: const EdgeInsets.only(bottom: 140),
              ),

            // Consumer Dot (always visible) - shows target direction
            Positioned(
              left: dotX - 15,
              top: dotY - 15,
              child: _buildGuidanceDot(isAligned: isAligned),
            ),

            // Alignment indicator (centered checkmark when aligned)
            if (widget.showAlignmentFeedback && isAligned)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.greenAccent,
                    size: 32,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  /// Builds the red guidance dot
  Widget _buildGuidanceDot({required bool isAligned}) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isAligned ? Colors.greenAccent.withOpacity(0.6) : Colors.red.withOpacity(0.6),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: (isAligned ? Colors.greenAccent : Colors.red).withOpacity(0.5),
            blurRadius: 12,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }

  /// Builds a directional arrow with dynamic opacity and size
  Widget _buildDirectionalArrow({
    required IconData icon,
    required Alignment alignment,
    required double intensity,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    // Scale arrow size from 32 to 56 based on intensity
    final arrowSize = 32.0 + (intensity * 24.0);

    // Scale opacity from 0.4 to 0.9 based on intensity
    final opacity = 0.4 + (intensity * 0.5);

    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.cyanAccent.withOpacity(opacity * 0.5),
              width: 1.5,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.cyanAccent.withOpacity(opacity),
            size: arrowSize,
          ),
        ),
      ),
    );
  }
}
