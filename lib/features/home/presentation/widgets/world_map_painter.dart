import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class WorldMapPainter extends CustomPainter {
  final ui.Image worldMapImage;
  final double scale;
  final Offset offset;
  final List<ProviderDot> providers;

  WorldMapPainter({
    required this.worldMapImage,
    required this.scale,
    required this.offset,
    required this.providers,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..filterQuality = FilterQuality.high;

    // Calculate how many times to repeat the map horizontally
    final imageWidth = worldMapImage.width.toDouble();
    final imageHeight = worldMapImage.height.toDouble();
    final scaledWidth = imageWidth * scale;
    final scaledHeight = imageHeight * scale;

    // Normalize offset to [0, scaledWidth) for seamless wrapping
    final normalizedOffsetX = offset.dx % scaledWidth;

    // Draw multiple instances of the map for seamless horizontal wrap
    for (int i = -1; i <= 1; i++) {
      final xPosition = (i * scaledWidth) - normalizedOffsetX;

      final srcRect = Rect.fromLTWH(0, 0, imageWidth, imageHeight);
      final dstRect = Rect.fromLTWH(
        xPosition,
        offset.dy,
        scaledWidth,
        scaledHeight,
      );

      canvas.drawImageRect(worldMapImage, srcRect, dstRect, paint);
    }

    // Draw provider dots
    for (final provider in providers) {
      _drawProviderDot(canvas, size, provider);
    }
  }

  void _drawProviderDot(Canvas canvas, Size size, ProviderDot provider) {
    final imageWidth = worldMapImage.width.toDouble();
    final imageHeight = worldMapImage.height.toDouble();
    final scaledWidth = imageWidth * scale;
    final scaledHeight = imageHeight * scale;

    // Convert lat/lng to normalized coordinates (0-1)
    final normalizedX = (provider.longitude + 180.0) / 360.0;
    final normalizedY = (90.0 - provider.latitude) / 180.0;

    // Convert to pixel position
    final baseX = normalizedX * scaledWidth;
    final baseY = normalizedY * scaledHeight + offset.dy;

    // Draw dots with wrapping (show on both sides if near edge)
    final normalizedOffsetX = offset.dx % scaledWidth;
    
    for (int i = -1; i <= 1; i++) {
      final dotX = baseX + (i * scaledWidth) - normalizedOffsetX;
      
      // Only draw if visible on screen
      if (dotX >= -50 && dotX <= size.width + 50) {
        _paintDot(canvas, Offset(dotX, baseY), provider.scale);
      }
    }
  }

  void _paintDot(Canvas canvas, Offset position, double dotScale) {
    // Outer glow
    final glowPaint = Paint()
      ..color = const Color(0xFF3B82F6).withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawCircle(position, 16 * dotScale, glowPaint);

    // Core dot
    final corePaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position, 8 * dotScale, corePaint);

    // Center highlight
    final highlightPaint = Paint()
      ..color = const Color(0xFF60A5FA)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position, 4 * dotScale, highlightPaint);
  }

  @override
  bool shouldRepaint(WorldMapPainter oldDelegate) {
    return oldDelegate.scale != scale ||
           oldDelegate.offset != offset ||
           oldDelegate.providers != providers;
  }
}

class ProviderDot {
  final double latitude;
  final double longitude;
  final String name;
  final double scale;

  ProviderDot({
    required this.latitude,
    required this.longitude,
    required this.name,
    this.scale = 1.0,
  });
}
