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

  // Point object state (consumer only)
  bool _isPointingMode = false;

  // Zoom state (consumer only)
  double _currentZoom = 1.0;      // Intended zoom (UI truth)
  double _lastSentZoom = 1.0;     // Last zoom value sent to backend

  // Provider zoom state (for render transform)
  double _providerZoom = 1.0;     // Provider's current zoom level

  // Point overlay position (provider only) - normalized 0-1 coordinates
  Offset? _pointPosition;
  
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
  /// Format: x is integer part (0-1000), y is decimal part (0.000-0.999)
  /// Example: x=0.5, y=0.3 -> 500.300
  double _encodeCoordinates(double x, double y) {
    final xInt = (x.clamp(0.0, 1.0) * 1000).round();
    final yDec = y.clamp(0.0, 0.999);
    return xInt + yDec;
  }

  /// Decode x,y coordinates from a single float value
  Offset? _decodeCoordinates(double value) {
    if (value < 0) return null; // Negative = clear point
    
    final xInt = value.truncate();
    final y = value - xInt;
    final x = xInt / 1000.0;
    
    return Offset(x.clamp(0.0, 1.0), y.clamp(0.0, 1.0));
  }

  void _handleControlEvent(ControlEvent event) {
    if (!widget.isProvider) return;
    if (!event.hasCommand()) return;

    final command = event.command;
    log('🎮 [CONTROL] Received command: ${command.type}');

    switch (command.type) {
      case CommandType.ZOOM_IN:
        // Use value field for delta, default to 0.1 if not set
        final delta = command.value > 0 ? command.value : 0.1;
        log('🔎 [CONTROL] Zoom IN received (delta=$delta)');
        ref.read(sessionRepositoryProvider).applyZoom(delta);
        // Update provider zoom for render transform
        setState(() {
          _providerZoom = (_providerZoom + delta).clamp(1.0, kMaxZoom);
        });
        break;
      case CommandType.ZOOM_OUT:
        // Use value field for delta, default to 0.1 if not set
        final delta = command.value > 0 ? command.value : 0.1;
        log('🔎 [CONTROL] Zoom OUT received (delta=$delta)');
        ref.read(sessionRepositoryProvider).applyZoom(-delta);
        // Update provider zoom for render transform
        setState(() {
          _providerZoom = (_providerZoom - delta).clamp(1.0, kMaxZoom);
        });
        break;
      case CommandType.POINT_TO_OBJECT:
        log('📍 [CONTROL] Point received: value=${command.value}');
        final point = _decodeCoordinates(command.value);
        setState(() {
          _pointPosition = point; // null if negative (clear command)
        });
        if (point == null) {
          log('📍 [CONTROL] Point cleared');
        } else {
          log('📍 [CONTROL] Point decoded: (${point.dx}, ${point.dy})');
        }
        break;
      default:
        log('⚠️ [CONTROL] Unhandled command: ${command.type}');
    }
  }

  // Consumer: Send zoom delta from slider
  void _onZoomSliderChanged(double value) {
    if (widget.isProvider || _controlService == null) return;
    
    final delta = value - _lastSentZoom;
    
    setState(() {
      _currentZoom = value;
    });
    
    // Ignore micro noise
    if (delta.abs() < 0.005) return;
    
    _lastSentZoom = value;
    _controlService!.sendZoomDelta(widget.sessionId, delta);
    log('📹 [ZOOM] Slider value: $value, delta: $delta');
  }

  // Consumer: Reset zoom to 1.0 (normal view)
  void _resetZoom() {
    if (widget.isProvider || _controlService == null) return;
    
    final delta = 1.0 - _lastSentZoom;
    
    setState(() {
      _currentZoom = 1.0;
    });
    
    _lastSentZoom = 1.0;
    
    if (delta.abs() < 0.005) return;
    
    _controlService!.sendZoomDelta(widget.sessionId, delta);
    log('📹 [ZOOM] Reset to 1.0, delta: $delta');
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
    
    // Encode x,y into single value
    final encodedValue = _encodeCoordinates(x, y);

    _controlService!.sendPointObject(widget.sessionId, encodedValue, 0); // y unused
    log('📍 [POINT] Sent point at ($x, $y) encoded as $encodedValue');

    // Exit pointing mode
    setState(() {
      _isPointingMode = false;
    });
  }

  // Consumer: Clear point
  void _sendClearPoint() {
    if (widget.isProvider || _controlService == null) return;
    
    // Negative value signals clear
    _controlService!.sendPointObject(widget.sessionId, -1.0, 0);
    log('📍 [POINT] Sent clear point command');
  }

  /// Provider: Build video with point-centered digital zoom (ROI crop)
  /// Uses ClipRect + OverflowBox + Transform for true viewport cropping
  /// This is render-time digital zoom, not camera zoom
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

  @override
  void dispose() {
    _controlSubscription?.cancel();
    _controlService?.dispose();
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
                      : RTCVideoView(_remoteRenderer, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),
                ),
              ),

              // Provider: Point Overlay - positioned relative to video rect
              if (widget.isProvider && _pointPosition != null)
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

              // Consumer: Pointing mode indicator
              if (!widget.isProvider && _isPointingMode)
                Positioned(
                  top: 60,
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

              // Consumer Controls (above End Call)
              if (!widget.isProvider && _inited)
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
                            // Zoom value display
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
                            // Reset button
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
}
