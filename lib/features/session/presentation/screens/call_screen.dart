import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import 'package:xeniqclone/core/services/grpc/live_control_service.dart';
import 'package:xeniqclone/src/generated/xeniq.pb.dart';
import 'package:xeniqclone/features/session/presentation/providers/session_provider.dart';
import 'package:xeniqclone/features/control/models/control_mode.dart';
import 'package:xeniqclone/features/control/services/gyroscope_controller.dart';
import 'package:xeniqclone/features/control/services/provider_gyroscope_tracker.dart';
import 'package:xeniqclone/features/control/widgets/guidance_overlay.dart';

/// Movement state for provider-side animation
enum MovementState {
  none,
  forward,
  backward,
  stop,
}

class CallScreen extends ConsumerStatefulWidget {
  final String sessionId;
  final bool isProvider;

  const CallScreen({super.key, required this.sessionId, required this.isProvider});

  @override
  ConsumerState<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  bool _inited = false;

  // Control stream
  LiveControlService? _controlService;
  StreamSubscription? _controlSubscription;

  // ================================
  // MODE STATE (Consumer)
  // ================================
  ControlMode _currentMode = ControlMode.button;

  // ================================
  // BUTTON MODE STATE (Consumer)
  // ================================
  bool _isPointingMode = false;
  double _currentZoom = 1.0;
  Offset _zoomAnchor = const Offset(0.5, 0.5); // Default to center
  
  // Throttle timer for state updates (~10Hz max)
  Timer? _stateThrottleTimer;
  bool _stateUpdatePending = false;

  // ================================
  // GYROSCOPE MODE STATE (Consumer)
  // ================================
  GyroscopeController? _gyroController;
  StreamSubscription? _gyroSubscription;

  // ================================
  // PROVIDER STATE
  // ================================
  double _providerZoom = 1.0;
  Offset _zoomAnchorReceived = const Offset(0.5, 0.5); // Received from consumer
  Offset? _pointPosition;
  
  // Gyroscope guidance state (provider)
  Offset _consumerDot = Offset.zero;
  Offset _providerDot = Offset.zero;
  bool _peerInGyroMode = false;
  ProviderGyroscopeTracker? _providerGyroTracker;
  StreamSubscription? _providerGyroSubscription;
  
  // Movement command state (provider)
  MovementState _movementState = MovementState.none;
  Timer? _stopAnimationTimer;
  
  // Active movement state (consumer - for button highlighting)
  MovementState _activeMovement = MovementState.none;
  
  // Widget size for layout
  Size _widgetSize = Size.zero;
  
  // Video aspect ratio (width/height) - assumed 16:9 for camera
  static const double _videoAspectRatio = 16.0 / 9.0;
  
  // Max zoom constant
  static const double kMaxZoom = 6.0;

  @override
  void initState() {
    super.initState();
    _initRenderers();
    
    // Register force-exit callback for auto call termination
    ref.read(sessionRepositoryProvider).setOnCallEndedCallback(() {
      if (mounted) {
        log('🚪 [CALL] Force-exiting call screen');
        context.pop();
      }
    });
  }

  Future<void> _initRenderers() async {
    log('[WEBRTC] ${widget.isProvider ? "Provider" : "Consumer"} initializing renderers...');
    
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    
    log('✅ [WEBRTC] Renderers initialized');
    
    setState(() => _inited = true);
    
    // Start session AFTER renderers are ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isProvider) {
        ref.read(sessionRepositoryProvider).createSession(widget.sessionId);
      } else {
        ref.read(sessionRepositoryProvider).joinSession(widget.sessionId);
      }
      _initControlStream();
    });
  }

  Future<void> _initControlStream() async {
    try {
      _controlService = LiveControlService();
      
      log('🎮 [CONTROL] Starting control stream as ${widget.isProvider ? "Provider" : "Consumer"}');
      
      final responseStream = await _controlService!.startSession(
        widget.sessionId, 
        widget.isProvider,
      );
      
      // Provider listens for commands
      if (widget.isProvider) {
        _controlSubscription = responseStream.listen(
          _handleControlEvent,
          onError: (error) => log('❌ [CONTROL] Stream error: $error'),
          onDone: () => log('🎮 [CONTROL] Stream closed'),
        );
      }
      
      log('✅ [CONTROL] Control stream connected');
    } catch (e) {
      log('❌ [CONTROL] Failed to connect: $e');
    }
  }

  // ================================
  // MODE SWITCHING (Consumer)
  // ================================
  
  void _switchToMode(ControlMode mode) {
    if (widget.isProvider) return;
    if (_currentMode == mode) return;
    
    log('🔄 [MODE] Switching from $_currentMode to $mode');
    
    // Cleanup previous mode
    if (_currentMode == ControlMode.gyroscope) {
      _stopGyroscopeMode();
    }
    
    setState(() {
      _currentMode = mode;
      _isPointingMode = false; // Reset pointing mode on switch
    });
    
    // Start new mode
    if (mode == ControlMode.gyroscope) {
      _startGyroscopeMode();
    }
  }
  
  void _startGyroscopeMode() {
    log('🌀 [GYRO] Starting gyroscope mode');
    _gyroController = GyroscopeController();
    _gyroController!.start();
    
    // Subscribe to orientation updates and dispatch to backend
    _gyroSubscription = _gyroController!.orientationStream.listen((orientation) {
      if (_controlService != null) {
        _controlService!.sendGyroOrientation(
          widget.sessionId,
          orientation.dx, // yaw
          orientation.dy, // pitch
        );
      }
    });
  }
  
  void _stopGyroscopeMode() {
    log('🛑 [GYRO] Stopping gyroscope mode');
    _gyroSubscription?.cancel();
    _gyroController?.dispose();
    _gyroController = null;
    _gyroSubscription = null;
  }
  
  void _recenterGyro() {
    if (_gyroController != null) {
      _gyroController!.reset();
      _controlService?.sendGyroReset(widget.sessionId);
      log('🔄 [GYRO] Recenter triggered');
    }
  }

  // ================================
  // PROVIDER GYRO TRACKING
  // ================================
  
  void _startProviderGyroTracking() {
    if (!widget.isProvider || _providerGyroTracker != null) return;
    
    log('🌀 [PROVIDER] Starting gyro tracking');
    _providerGyroTracker = ProviderGyroscopeTracker();
    _providerGyroTracker!.start();
    
    _providerGyroSubscription = _providerGyroTracker!.orientationStream.listen((orientation) {
      setState(() {
        _providerDot = orientation;
      });
    });
  }
  
  void _stopProviderGyroTracking() {
    log('🛑 [PROVIDER] Stopping gyro tracking');
    _providerGyroSubscription?.cancel();
    _providerGyroTracker?.dispose();
    _providerGyroTracker = null;
    _providerGyroSubscription = null;
  }

  /// Calculate the video rect within widget bounds
  /// This accounts for BoxFit.cover behavior
  Rect _calculateVideoRect() {
    if (_widgetSize == Size.zero) return Rect.zero;
    
    final widgetAspect = _widgetSize.width / _widgetSize.height;
    
    double videoWidth, videoHeight;
    double offsetX = 0, offsetY = 0;
    
    if (widgetAspect > _videoAspectRatio) {
      // Widget is wider than video - video fills width, centered vertically
      videoWidth = _widgetSize.width;
      videoHeight = _widgetSize.width / _videoAspectRatio;
      offsetY = (_widgetSize.height - videoHeight) / 2;
    } else {
      // Widget is taller than video - video fills height, centered horizontally
      videoHeight = _widgetSize.height;
      videoWidth = _widgetSize.height * _videoAspectRatio;
      offsetX = (_widgetSize.width - videoWidth) / 2;
    }
    
    return Rect.fromLTWH(offsetX, offsetY, videoWidth, videoHeight);
  }

  /// Encode x,y coordinates into a single float value
  double _encodeCoordinates(double x, double y) {
    final xInt = (x.clamp(0.0, 1.0) * 1000).round();
    final yDec = y.clamp(0.0, 0.999);
    return xInt + yDec;
  }

  /// Decode x,y coordinates from a single float value
  Offset? _decodeCoordinates(double value) {
    if (value < 0) return null;
    
    final xInt = value.truncate();
    final y = value - xInt;
    final x = xInt / 1000.0;
    
    return Offset(x.clamp(0.0, 1.0), y.clamp(0.0, 1.0));
  }

  void _handleControlEvent(ControlEvent event) {
    if (!widget.isProvider) return;

    // Handle CameraState (state-based sync - preferred)
    if (event.hasState()) {
      final state = event.state;
      log('📐 [CONTROL] Received state: zoom=${state.zoomLevel} anchor=(${state.anchorX},${state.anchorY}) mode=${state.mode}');
      
      setState(() {
        _providerZoom = state.zoomLevel;
        _zoomAnchorReceived = Offset(state.anchorX, state.anchorY);
        _peerInGyroMode = state.mode == ControlModeType.CONTROL_MODE_GYRO;
        
        // Update point position to match zoom anchor
        if (!_peerInGyroMode) {
          _pointPosition = _zoomAnchorReceived;
        }
      });
      
      // Apply camera zoom
      ref.read(sessionRepositoryProvider).setZoomLevel(state.zoomLevel);
      
      // Start/stop gyro tracking based on mode
      if (_peerInGyroMode && _providerGyroTracker == null) {
        _startProviderGyroTracking();
      } else if (!_peerInGyroMode && _providerGyroTracker != null) {
        _stopProviderGyroTracking();
      }
      return;
    }

    // Handle gyro data
    if (event.hasGyro()) {
      final gyro = event.gyro;
      log('🌀 [CONTROL] Received gyro: yaw=${gyro.yaw}, pitch=${gyro.pitch}');
      
      // First gyro data = peer entered gyro mode
      if (!_peerInGyroMode) {
        setState(() {
          _peerInGyroMode = true;
        });
        _startProviderGyroTracking();
      }
      
      setState(() {
        _consumerDot = Offset(gyro.yaw, gyro.pitch);
      });
      return;
    }

    if (!event.hasCommand()) return;

    final command = event.command;
    log('🎮 [CONTROL] Received command: ${command.type}');

    switch (command.type) {
      case CommandType.ZOOM_IN:
        final delta = command.value > 0 ? command.value : 0.1;
        log('🔎 [CONTROL] Zoom IN received (delta=$delta)');
        ref.read(sessionRepositoryProvider).applyZoom(delta);
        setState(() {
          _providerZoom = (_providerZoom + delta).clamp(1.0, kMaxZoom);
        });
        break;
      case CommandType.ZOOM_OUT:
        final delta = command.value > 0 ? command.value : 0.1;
        log('🔎 [CONTROL] Zoom OUT received (delta=$delta)');
        ref.read(sessionRepositoryProvider).applyZoom(-delta);
        setState(() {
          _providerZoom = (_providerZoom - delta).clamp(1.0, kMaxZoom);
        });
        break;
      case CommandType.POINT_TO_OBJECT:
        log('📍 [CONTROL] Point received: value=${command.value}');
        final point = _decodeCoordinates(command.value);
        setState(() {
          _pointPosition = point;
          // Exit gyro mode if consumer sent point command
          if (_peerInGyroMode) {
            _peerInGyroMode = false;
            _stopProviderGyroTracking();
          }
        });
        if (point == null) {
          log('📍 [CONTROL] Point cleared');
        } else {
          log('📍 [CONTROL] Point decoded: (${point.dx}, ${point.dy})');
        }
        break;
      case CommandType.GYRO_RESET:
        log('🔄 [CONTROL] Gyro reset received');
        setState(() {
          _consumerDot = Offset.zero;
          _providerDot = Offset.zero;
        });
        _providerGyroTracker?.reset();
        break;
      case CommandType.MOVE_FORWARD:
        log('⬆️ [CONTROL] Move forward received');
        _stopAnimationTimer?.cancel();
        setState(() {
          _movementState = MovementState.forward;
        });
        break;
      case CommandType.MOVE_BACKWARD:
        log('⬇️ [CONTROL] Move backward received');
        _stopAnimationTimer?.cancel();
        setState(() {
          _movementState = MovementState.backward;
        });
        break;
      case CommandType.STOP:
        log('✋ [CONTROL] Stop received');
        _stopAnimationTimer?.cancel();
        setState(() {
          _movementState = MovementState.stop;
        });
        // Auto-clear STOP after 1 second
        _stopAnimationTimer = Timer(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              _movementState = MovementState.none;
            });
          }
        });
        break;
      default:
        log('⚠️ [CONTROL] Unhandled command: ${command.type}');
    }
  }

  // Consumer: Send state when zoom slider changes (throttled)
  void _onZoomSliderChanged(double value) {
    if (widget.isProvider || _controlService == null) return;
    
    setState(() {
      _currentZoom = value;
    });
    
    // Throttle state updates to 10Hz
    _scheduleStateUpdate();
  }
  
  // Throttled state dispatch
  void _scheduleStateUpdate() {
    if (_stateUpdatePending) return;
    _stateUpdatePending = true;
    
    _stateThrottleTimer?.cancel();
    _stateThrottleTimer = Timer(const Duration(milliseconds: 100), () {
      _stateUpdatePending = false;
      _sendCurrentState();
    });
  }
  
  // Send current camera state
  void _sendCurrentState() {
    if (_controlService == null) return;
    
    _controlService!.sendCameraState(
      widget.sessionId,
      zoomLevel: _currentZoom,
      anchorX: _zoomAnchor.dx,
      anchorY: _zoomAnchor.dy,
      isGyroMode: _currentMode == ControlMode.gyroscope,
    );
    log('📐 [STATE] Sent: zoom=$_currentZoom anchor=$_zoomAnchor');
  }

  // Consumer: Reset zoom to 1.0 (normal view)
  void _resetZoom() {
    if (widget.isProvider || _controlService == null) return;
    
    setState(() {
      _currentZoom = 1.0;
      _zoomAnchor = const Offset(0.5, 0.5);
    });
    
    _sendCurrentState();
    log('📹 [ZOOM] Reset to 1.0');
  }

  // Consumer: Handle video tap for point object
  void _handleVideoTap(TapUpDetails details) {
    if (widget.isProvider) return;
    if (!_isPointingMode) return;
    if (_controlService == null) return;

    // Calculate video rect for accurate mapping
    final videoRect = _calculateVideoRect();
    
    // Get tap position relative to video rect
    final tapX = details.localPosition.dx - videoRect.left;
    final tapY = details.localPosition.dy - videoRect.top;
    
    // Normalize coordinates relative to video rect
    final x = (tapX / videoRect.width).clamp(0.0, 1.0);
    final y = (tapY / videoRect.height).clamp(0.0, 1.0);
    
    // Set zoom anchor to tap position
    setState(() {
      _zoomAnchor = Offset(x, y);
      _isPointingMode = false;
    });
    
    // Send updated state with new anchor
    _sendCurrentState();
    log('📍 [POINT] Set zoom anchor at ($x, $y)');
  }

  // Consumer: Clear point
  void _sendClearPoint() {
    if (widget.isProvider || _controlService == null) return;
    
    // Negative value signals clear
    _controlService!.sendPointObject(widget.sessionId, -1.0, 0);
    log('📍 [POINT] Sent clear point command');
  }

  /// Provider: Build video with point-centered digital zoom (ROI crop)
  Widget _buildPointCenteredZoomVideo(Widget video) {
    // No transform if zoom is 1.0 or no point
    if (_providerZoom <= 1.01 || _pointPosition == null) {
      return video;
    }

    final videoWidth = _widgetSize.width;
    final videoHeight = _widgetSize.height;

    // Calculate the visible crop area at this zoom level
    final cropWidth = videoWidth / _providerZoom;
    final cropHeight = videoHeight / _providerZoom;

    // Calculate center point in pixel coordinates
    final centerX = _pointPosition!.dx * videoWidth;
    final centerY = _pointPosition!.dy * videoHeight;

    // Calculate crop offset, clamped to valid range
    final left = (centerX - cropWidth / 2).clamp(0.0, videoWidth - cropWidth);
    final top = (centerY - cropHeight / 2).clamp(0.0, videoHeight - cropHeight);

    return ClipRect(
      child: OverflowBox(
        maxWidth: videoWidth,
        maxHeight: videoHeight,
        alignment: Alignment.topLeft,
        child: Transform.translate(
          offset: Offset(-left, -top),
          child: Transform.scale(
            scale: _providerZoom,
            alignment: Alignment.topLeft,
            child: video,
          ),
        ),
      ),
    );
  }
  
  /// Consumer: Build zoomed remote video (render-time transform only)
  /// Uses zoom anchor for proper viewport centering
  Widget _buildConsumerZoomedVideo(Widget video) {
    // No transform if zoom is 1.0
    if (_currentZoom <= 1.01) {
      return video;
    }

    final videoWidth = _widgetSize.width;
    final videoHeight = _widgetSize.height;

    // Calculate the visible crop area at this zoom level
    final cropWidth = videoWidth / _currentZoom;
    final cropHeight = videoHeight / _currentZoom;

    // Calculate center point in pixel coordinates using anchor
    final centerX = _zoomAnchor.dx * videoWidth;
    final centerY = _zoomAnchor.dy * videoHeight;

    // Calculate crop offset, clamped to valid range
    final left = (centerX - cropWidth / 2).clamp(0.0, videoWidth - cropWidth);
    final top = (centerY - cropHeight / 2).clamp(0.0, videoHeight - cropHeight);

    return ClipRect(
      child: OverflowBox(
        maxWidth: videoWidth,
        maxHeight: videoHeight,
        alignment: Alignment.topLeft,
        child: Transform.translate(
          offset: Offset(-left, -top),
          child: Transform.scale(
            scale: _currentZoom,
            alignment: Alignment.topLeft,
            child: video,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stateThrottleTimer?.cancel();
    _stopAnimationTimer?.cancel();
    _controlSubscription?.cancel();
    _controlService?.dispose();
    _gyroSubscription?.cancel();
    _gyroController?.dispose();
    _providerGyroSubscription?.cancel();
    _providerGyroTracker?.dispose();
    ref.read(sessionRepositoryProvider).endSession();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to streams and attach to renderers
    ref.listen<AsyncValue<MediaStream>>(localStreamProvider, (previous, next) {
      next.whenData((stream) {
        if (_inited && _localRenderer.srcObject == null) {
          log('✅ [WEBRTC] Local stream attached to renderer');
          setState(() {
            _localRenderer.srcObject = stream;
          });
        }
      });
    });
    
    ref.listen<AsyncValue<MediaStream>>(remoteStreamProvider, (previous, next) {
      next.whenData((stream) {
        if (_inited && _remoteRenderer.srcObject == null) {
          log('✅ [WEBRTC] Remote stream attached to renderer');
          setState(() {
            _remoteRenderer.srcObject = stream;
          });
        }
      });
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          _widgetSize = Size(constraints.maxWidth, constraints.maxHeight);
          final videoRect = _calculateVideoRect();
          
          return Stack(
            children: [
              // Main Video View
              Positioned.fill(
                child: GestureDetector(
                  onTapUp: widget.isProvider ? null : _handleVideoTap,
                  child: widget.isProvider
                      ? _buildPointCenteredZoomVideo(
                          RTCVideoView(_localRenderer, mirror: false, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),
                        )
                      : _buildConsumerZoomedVideo(
                          RTCVideoView(_remoteRenderer, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),
                        ),
                ),
              ),

              // Provider: Point Overlay (only in button mode)
              if (widget.isProvider && _pointPosition != null && !_peerInGyroMode)
                Positioned(
                  left: videoRect.left + (_pointPosition!.dx * videoRect.width) - 10,
                  top: videoRect.top + (_pointPosition!.dy * videoRect.height) - 10,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.6),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),

              // Provider: Guidance Overlay (when peer is in gyro mode)
              if (widget.isProvider && _peerInGyroMode)
                Positioned.fill(
                  child: IgnorePointer(
                    child: GuidanceOverlay(
                      consumerDot: _consumerDot,
                      providerDot: _providerDot,
                      showAlignmentFeedback: true,
                    ),
                  ),
                ),

              // Provider: Movement Animation Overlay
              if (widget.isProvider && _movementState != MovementState.none)
                Positioned.fill(
                  child: IgnorePointer(
                    child: _buildMovementOverlay(),
                  ),
                ),

              // Consumer: Mode Switch UI
              if (!widget.isProvider && _inited)
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildModeButton(
                            label: 'Buttons',
                            icon: Icons.touch_app,
                            isActive: _currentMode == ControlMode.button,
                            onTap: () => _switchToMode(ControlMode.button),
                          ),
                          const SizedBox(width: 8),
                          _buildModeButton(
                            label: 'Gyroscope',
                            icon: Icons.screen_rotation,
                            isActive: _currentMode == ControlMode.gyroscope,
                            onTap: () => _switchToMode(ControlMode.gyroscope),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Consumer: Pointing mode indicator
              if (!widget.isProvider && _isPointingMode && _currentMode == ControlMode.button)
                Positioned(
                  top: 110,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Tap on video to place point',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),

              // Consumer Controls - Button Mode
              if (!widget.isProvider && _inited && _currentMode == ControlMode.button)
                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      // Zoom Slider with value display
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            Text(
                              '${_currentZoom.toStringAsFixed(2)}×',
                              style: const TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Text('1×', style: TextStyle(color: Colors.white54, fontSize: 12)),
                                Expanded(
                                  child: Slider(
                                    value: _currentZoom,
                                    min: 1.0,
                                    max: kMaxZoom,
                                    divisions: 80,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.white24,
                                    onChanged: _onZoomSliderChanged,
                                  ),
                                ),
                                const Text('6×', style: TextStyle(color: Colors.white54, fontSize: 12)),
                              ],
                            ),
                            TextButton(
                              onPressed: _resetZoom,
                              child: const Text(
                                'Reset Zoom',
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Point Object and Remove Point buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildControlButton(
                            icon: Icons.touch_app,
                            label: 'Point',
                            onPressed: () {
                              setState(() {
                                _isPointingMode = !_isPointingMode;
                              });
                            },
                            isActive: _isPointingMode,
                          ),
                          const SizedBox(width: 16),
                          _buildControlButton(
                            icon: Icons.close,
                            label: 'Clear',
                            onPressed: _sendClearPoint,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              // Consumer Controls - Gyroscope Mode
              if (!widget.isProvider && _inited && _currentMode == ControlMode.gyroscope)
                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          'Tilt your phone to guide the camera',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        // Movement buttons row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildMovementButton(
                              icon: Icons.arrow_upward_rounded,
                              label: 'Forward',
                              state: MovementState.forward,
                            ),
                            const SizedBox(width: 12),
                            _buildMovementButton(
                              icon: Icons.pan_tool_rounded,
                              label: 'Stop',
                              state: MovementState.stop,
                            ),
                            const SizedBox(width: 12),
                            _buildMovementButton(
                              icon: Icons.arrow_downward_rounded,
                              label: 'Backward',
                              state: MovementState.backward,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: _recenterGyro,
                          icon: const Icon(Icons.center_focus_strong),
                          label: const Text('Recenter'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.withOpacity(0.8),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              
              // End Call Button (both roles)
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.call_end, size: 32),
                    onPressed: () async {
                      log('🛑 [CALL] Local end initiated');
                      await ref.read(sessionRepositoryProvider).endSession();
                      if (context.mounted) {
                        context.pop();
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildModeButton({
    required String label,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.blue : Colors.white.withOpacity(0.2),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Build movement button for gyroscope mode (consumer)
  Widget _buildMovementButton({
    required IconData icon,
    required String label,
    required MovementState state,
  }) {
    final isActive = _activeMovement == state;
    
    return GestureDetector(
      onTap: () {
        if (_controlService == null) return;
        
        // Determine command type
        CommandType commandType;
        switch (state) {
          case MovementState.forward:
            commandType = CommandType.MOVE_FORWARD;
            break;
          case MovementState.backward:
            commandType = CommandType.MOVE_BACKWARD;
            break;
          case MovementState.stop:
            commandType = CommandType.STOP;
            break;
          default:
            return;
        }
        
        // Send command
        _controlService!.sendCommand(widget.sessionId, commandType);
        log('📤 [MOVEMENT] Sent $commandType');
        
        // Update active state
        setState(() {
          if (state == MovementState.stop) {
            // STOP cancels any active movement
            _activeMovement = MovementState.none;
          } else if (_activeMovement == state) {
            // Tapping same movement again? Keep it active (continuous)
            _activeMovement = state;
          } else {
            // Switch to new movement
            _activeMovement = state;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive 
              ? (state == MovementState.stop ? Colors.orange : Colors.green)
              : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
            width: isActive ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build movement animation overlay for provider
  Widget _buildMovementOverlay() {
    switch (_movementState) {
      case MovementState.forward:
        return _buildDirectionAnimation(isForward: true);
      case MovementState.backward:
        return _buildDirectionAnimation(isForward: false);
      case MovementState.stop:
        return _buildStopAnimation();
      default:
        return const SizedBox.shrink();
    }
  }

  /// Animated arrows for forward/backward movement
  Widget _buildDirectionAnimation({required bool isForward}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Triple arrow indicator with pulse effect
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.5, end: 1.0),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, isForward ? -10 * (1 - value) : 10 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.cyanAccent.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    isForward ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                    color: Colors.cyanAccent,
                    size: 48,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isForward ? 'MOVE FORWARD' : 'MOVE BACKWARD',
                    style: const TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Stop hand animation
  Widget _buildStopAnimation() {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 300),
        builder: (context, value, child) {
          return Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.orangeAccent.withOpacity(0.7),
              width: 3,
            ),
          ),
          child: const Icon(
            Icons.pan_tool_rounded,
            color: Colors.orangeAccent,
            size: 56,
          ),
        ),
      ),
    );
  }
}
