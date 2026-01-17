import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Controller for handling gyroscope input and producing smoothed orientation values.
/// Uses sensor fusion of gyroscope and accelerometer for stable yaw/pitch output.
class GyroscopeController {
  // Sensor subscriptions
  StreamSubscription<GyroscopeEvent>? _gyroSubscription;
  StreamSubscription<AccelerometerEvent>? _accelSubscription;
  
  // Output stream for filtered orientation
  final StreamController<Offset> _orientationController = StreamController<Offset>.broadcast();
  
  /// Stream of normalized orientation values (yaw, pitch) in range [-1, +1]
  Stream<Offset> get orientationStream => _orientationController.stream;
  
  // Raw sensor values
  double _rawGyroX = 0; // Pitch rate (rad/s)
  double _rawGyroY = 0; // Yaw rate (rad/s)
  
  // Accumulated orientation relative to reference
  double _accumulatedYaw = 0;   // Left/right
  double _accumulatedPitch = 0; // Up/down
  
  // Reference point (set on reset)
  double _referenceYaw = 0;
  double _referencePitch = 0;
  
  // Low-pass filter state
  double _filteredYaw = 0;
  double _filteredPitch = 0;
  
  // Filter constants
  static const double _alpha = 0.15; // Low-pass filter coefficient (0.1-0.3 recommended)
  static const double _maxAngle = math.pi / 4; // 45 degrees max tilt
  
  // Update timer for throttled output
  Timer? _updateTimer;
  static const Duration _updateInterval = Duration(milliseconds: 66); // ~15Hz
  
  // Track if running
  bool _isRunning = false;
  
  /// Start listening to sensors and producing orientation updates
  void start() {
    if (_isRunning) return;
    _isRunning = true;
    
    debugPrint('🌀 [GYRO] Starting gyroscope controller');
    
    // Subscribe to gyroscope
    _gyroSubscription = gyroscopeEventStream().listen((event) {
      // Gyroscope gives angular velocity in rad/s
      // Integrate over time to get angle change
      _rawGyroX = event.x; // Pitch rate
      _rawGyroY = event.y; // Yaw rate
      
      // Accumulate angle changes (assuming ~60Hz sample rate)
      final dt = 1.0 / 60.0;
      _accumulatedPitch += _rawGyroX * dt;
      _accumulatedYaw += _rawGyroY * dt;
    });
    
    // Subscribe to accelerometer for gravity reference (stabilization)
    _accelSubscription = accelerometerEventStream().listen((event) {
      // Use accelerometer to correct drift
      // This is a simplified gravity-based correction
      final gravityX = event.x;
      final gravityY = event.y;
      
      // Blend accelerometer estimate with gyro integration
      // This reduces drift over time
      final accelPitch = math.atan2(gravityX, 9.8);
      final accelYaw = math.atan2(gravityY, 9.8);
      
      // Complementary filter: trust gyro short-term, accel long-term
      const accelWeight = 0.02;
      _accumulatedPitch = _accumulatedPitch * (1 - accelWeight) + accelPitch * accelWeight;
      _accumulatedYaw = _accumulatedYaw * (1 - accelWeight) + accelYaw * accelWeight;
    });
    
    // Start update timer for throttled output
    _updateTimer = Timer.periodic(_updateInterval, (_) => _emitFilteredOrientation());
    
    debugPrint('✅ [GYRO] Controller started');
  }
  
  void _emitFilteredOrientation() {
    // Calculate relative orientation from reference
    final relativeYaw = _accumulatedYaw - _referenceYaw;
    final relativePitch = _accumulatedPitch - _referencePitch;
    
    // Normalize to [-1, +1] range
    final normalizedYaw = (relativeYaw / _maxAngle).clamp(-1.0, 1.0);
    final normalizedPitch = (relativePitch / _maxAngle).clamp(-1.0, 1.0);
    
    // Apply low-pass filter for smoothing
    _filteredYaw = _alpha * normalizedYaw + (1 - _alpha) * _filteredYaw;
    _filteredPitch = _alpha * normalizedPitch + (1 - _alpha) * _filteredPitch;
    
    // Emit filtered values
    if (!_orientationController.isClosed) {
      _orientationController.add(Offset(_filteredYaw, _filteredPitch));
    }
  }
  
  /// Reset the orientation reference to current position (recenter)
  void reset() {
    debugPrint('🔄 [GYRO] Recentering orientation');
    _referenceYaw = _accumulatedYaw;
    _referencePitch = _accumulatedPitch;
    _filteredYaw = 0;
    _filteredPitch = 0;
    
    // Emit zero immediately
    if (!_orientationController.isClosed) {
      _orientationController.add(Offset.zero);
    }
  }
  
  /// Stop listening to sensors
  void stop() {
    debugPrint('🛑 [GYRO] Stopping gyroscope controller');
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
    debugPrint('🗑️ [GYRO] Controller disposed');
  }
}
