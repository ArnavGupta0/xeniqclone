import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Tracks the provider's local device orientation for displaying the provider dot.
/// Uses same sensor fusion and filtering as consumer's GyroscopeController for consistency.
class ProviderGyroscopeTracker {
  // Sensor subscriptions
  StreamSubscription<GyroscopeEvent>? _gyroSubscription;
  StreamSubscription<AccelerometerEvent>? _accelSubscription;
  
  // Output stream for filtered orientation
  final StreamController<Offset> _orientationController = StreamController<Offset>.broadcast();
  
  /// Stream of normalized orientation values (yaw, pitch) in range [-1, +1]
  Stream<Offset> get orientationStream => _orientationController.stream;
  
  // Raw sensor values
  double _rawGyroX = 0;
  double _rawGyroY = 0;
  
  // Accumulated orientation
  double _accumulatedYaw = 0;
  double _accumulatedPitch = 0;
  
  // Reference point
  double _referenceYaw = 0;
  double _referencePitch = 0;
  
  // Low-pass filter state
  double _filteredYaw = 0;
  double _filteredPitch = 0;
  
  // Constants - same as consumer for consistency
  static const double _alpha = 0.15;
  static const double _maxAngle = math.pi / 4;
  
  // Update timer
  Timer? _updateTimer;
  static const Duration _updateInterval = Duration(milliseconds: 50); // ~20Hz
  
  bool _isRunning = false;
  
  /// Start tracking provider device orientation
  void start() {
    if (_isRunning) return;
    _isRunning = true;
    
    debugPrint('🌀 [PROVIDER_GYRO] Starting orientation tracking');
    
    _gyroSubscription = gyroscopeEventStream().listen((event) {
      _rawGyroX = event.x;
      _rawGyroY = event.y;
      
      final dt = 1.0 / 60.0;
      _accumulatedPitch += _rawGyroX * dt;
      _accumulatedYaw += _rawGyroY * dt;
    });
    
    _accelSubscription = accelerometerEventStream().listen((event) {
      final gravityX = event.x;
      final gravityY = event.y;
      
      final accelPitch = math.atan2(gravityX, 9.8);
      final accelYaw = math.atan2(gravityY, 9.8);
      
      const accelWeight = 0.02;
      _accumulatedPitch = _accumulatedPitch * (1 - accelWeight) + accelPitch * accelWeight;
      _accumulatedYaw = _accumulatedYaw * (1 - accelWeight) + accelYaw * accelWeight;
    });
    
    _updateTimer = Timer.periodic(_updateInterval, (_) => _emitFilteredOrientation());
    
    debugPrint('✅ [PROVIDER_GYRO] Tracking started');
  }
  
  void _emitFilteredOrientation() {
    final relativeYaw = _accumulatedYaw - _referenceYaw;
    final relativePitch = _accumulatedPitch - _referencePitch;
    
    final normalizedYaw = (relativeYaw / _maxAngle).clamp(-1.0, 1.0);
    final normalizedPitch = (relativePitch / _maxAngle).clamp(-1.0, 1.0);
    
    _filteredYaw = _alpha * normalizedYaw + (1 - _alpha) * _filteredYaw;
    _filteredPitch = _alpha * normalizedPitch + (1 - _alpha) * _filteredPitch;
    
    if (!_orientationController.isClosed) {
      _orientationController.add(Offset(_filteredYaw, _filteredPitch));
    }
  }
  
  /// Reset reference point to current orientation
  void reset() {
    debugPrint('🔄 [PROVIDER_GYRO] Resetting reference');
    _referenceYaw = _accumulatedYaw;
    _referencePitch = _accumulatedPitch;
    _filteredYaw = 0;
    _filteredPitch = 0;
    
    if (!_orientationController.isClosed) {
      _orientationController.add(Offset.zero);
    }
  }
  
  /// Stop tracking
  void stop() {
    debugPrint('🛑 [PROVIDER_GYRO] Stopping tracking');
    _isRunning = false;
    _updateTimer?.cancel();
    _gyroSubscription?.cancel();
    _accelSubscription?.cancel();
    _gyroSubscription = null;
    _accelSubscription = null;
  }
  
  /// Dispose resources
  void dispose() {
    stop();
    _orientationController.close();
    debugPrint('🗑️ [PROVIDER_GYRO] Tracker disposed');
  }
}
