import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:xeniqclone/features/auth/domain/entities/app_user.dart';
import 'package:xeniqclone/features/auth/presentation/providers/auth_provider.dart';
import 'package:xeniqclone/features/home/presentation/widgets/menu_drawer.dart';
import 'package:xeniqclone/features/home/presentation/widgets/service_selection_modal.dart';
import 'package:xeniqclone/features/provider/presentation/providers/provider_status_provider.dart';
import 'package:xeniqclone/features/provider/presentation/providers/providers_list_provider.dart';
import 'package:xeniqclone/features/provider/services/provider_availability_service.dart';
import 'package:xeniqclone/features/call/presentation/dialogs/incoming_call_dialog.dart';
import 'package:xeniqclone/features/call/presentation/screens/call_screen.dart';
import 'package:xeniqclone/src/generated/xeniq.pb.dart';
import 'package:xeniqclone/features/call/services/incoming_call_listener_service.dart';
import 'dart:math';
import 'dart:async';

// ---------------------------------------------------------------------------
// 1. DATA MODELS
// ---------------------------------------------------------------------------

class ProviderLocation {
  final LatLng location;
  final String name;

  ProviderLocation(this.location, this.name);
}

// ---------------------------------------------------------------------------
// 2. MAIN SCREEN
// ---------------------------------------------------------------------------

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  late MapController _mapController;
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;
  
  // Search & Validation State
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  bool _isVerifyingProvider = false;
  String? _providerError;
  
  // Background State
  bool _isInteracting = false;
  Offset _mapOffset = Offset.zero;
  
  // Global Provider List (Fetched from Riverpod)
  // No local state needed for providers

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    
    // Antigravity Floating Animation (Visual Only)
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    
    _floatingAnimation = Tween<double>(begin: -4.0, end: 4.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOutSine),
    );
    
    // Shake Animation
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    // Initialize Signaling & Polling
    WidgetsBinding.instance.addPostFrameCallback((_) {
       debugPrint('[APP] Post-frame callback executing...');
       final user = ref.read(currentUserProvider).valueOrNull;
       if (user != null) {
          debugPrint('[APP] User found: ${user.id}');
          // 1. Initialize Self-Provider (Register Silently)
          ref.read(providerStatusProvider.notifier).initialize(user.id);
          debugPrint('[APP] ProviderStatusNotifier.initialize() called for user: ${user.id}');

          // 2. Start Global Map Polling
          ref.read(providersListProvider.notifier).startPolling();
       } else {
          debugPrint('[APP] WARNING: User is null in post-frame callback!');
       }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mapController.dispose();
    _floatingController.dispose();
    _shakeController.dispose();
    super.dispose();
  }
  
  void _onMapEvent(MapEvent event) {
    if (event is MapEventMoveStart || event is MapEventRotateStart) {
      setState(() => _isInteracting = true);
    } else if (event is MapEventMoveEnd || event is MapEventRotateEnd) {
      setState(() => _isInteracting = false);
    } else if (event is MapEventMove) {
       // Accumulate very slight offset for parallax
       // We divide by a large number so the background moves MUCH slower than the map
       setState(() {
         // Invert direction for depth feel
         _mapOffset -= Offset(event.camera.center.latitude, event.camera.center.longitude) * 0.5;
       });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final user = ref.watch(currentUserProvider).valueOrNull;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Earth radius R = min(screenWidth, screenHeight) * 0.42
    final minDimension = screenWidth < screenHeight ? screenWidth : screenHeight;
    final earthSize = minDimension * 0.84;

    return Scaffold(
      key: _scaffoldKey, // Key for opening drawer
      backgroundColor: const Color(0xFF020408), // Deepest Space Black
      drawer: const MenuDrawer(), // Dynamic Menu Drawer
      // floatingActionButton removed to fix overlap issue

      body: SafeArea(
        child: Stack(
          children: [
            // 0. VISUAL: Realistic Space Background
            // Deep Gradient Layer
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF050810), // Deepest Navy
                    Color(0xFF000000), // Pure Black Mid
                    Color(0xFF020305), // Void Black
                  ],
                ),
              ),
            ),
            
            // Interactive Star Field
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000), // Smooth transition for glow
                child: CustomPaint(
                  painter: RealisticStarFieldPainter(
                    isInteracting: _isInteracting,
                    parallaxOffset: _mapOffset,
                    time: DateTime.now().millisecondsSinceEpoch / 1000.0,
                  ),
                ),
              ),
            ),
          
            // Earth-style Globe Illusion with Floating Animation
            AnimatedBuilder(
              animation: _floatingAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatingAnimation.value),
                  child: Center(
                    child: SizedBox(
                      width: earthSize,
                      height: earthSize,
                      child: Stack(
                        children: [
                          // 1. CIRCULAR MASK (The Globe)
                          ClipOval(
                            child: Stack(
                              children: [
                                // Stable Map Engine (Infinite Scroll)
                                FlutterMap(
                                  mapController: _mapController,
                                  options: MapOptions(
                                      initialCenter: const LatLng(20.0, 0.0),
                                      initialZoom: 3.0,
                                      minZoom: 2.0,
                                      maxZoom: 20.0, // Unlocked Deep Zoom
                                      interactionOptions: const InteractionOptions(
                                        // Disable rotation to keep the "sphere" upright
                                        flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                                      ),
                                      onMapEvent: _onMapEvent, // Wiring Interaction
                                    ),
                                    children: [
                                      TileLayer(
                                        // UPGRADE: Switching to CartoDB Voyager to FORCE ENGLISH LABELS
                                        // This style provides detailed street data with consistent English names.
                                        urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                                        subdomains: const ['a', 'b', 'c', 'd'],
                                        userAgentPackageName: 'com.xeniq.clone',
                                        retinaMode: true, // Sharp tiles on high-DPI screens
                                        maxNativeZoom: 20, // Voyager supports deep zoom
                                      ),          
                                      
                                      // PROVIDER / LOCATION MARKER LAYER
                                      // PROVIDER / LOCATION MARKER LAYER
                                      Consumer(
                                        builder: (context, ref, _) {
                                          final providerState = ref.watch(providerStatusProvider);
                                          final markers = <Marker>[];

                                          // 1. Show Self if Provider
                                          if (providerState.isAvailable && providerState.location != null) {
                                             markers.add(
                                              Marker(
                                                point: providerState.location!,
                                                width: 80,
                                                height: 80,
                                                child: Column(
                                                  children: [
                                                    const Icon(Icons.place, color: Color(0xFF10B981), size: 40),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black.withOpacity(0.7),
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: const Text('You', style: TextStyle(color: Colors.white, fontSize: 10)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                             );
                                          } else if (providerState.location != null) {
                                            // "Locate Me" temporary marker
                                             markers.add(
                                              Marker(
                                                point: providerState.location!,
                                                width: 60,
                                                height: 60,
                                                child: const Icon(Icons.my_location, color: Colors.blueAccent, size: 32),
                                              ),
                                             );
                                          }
                                          
                                           // 2. Show Live Available Providers (Consumer View)
                                           final availableProviders = ref.watch(providersListProvider);
                                           final currentUserId = ref.read(currentUserProvider).valueOrNull?.id;
                                           
                                           for (var p in availableProviders) {
                                             // Skip self if we are also a provider
                                              if (currentUserId != null && p.providerId == currentUserId) continue;
                                            
                                            markers.add(
                                              Marker(
                                                point: LatLng(p.latitude, p.longitude),
                                                width: 80,
                                                height: 80,
                                                child: GestureDetector(
                                                  onTap: () {
                                                     // Open Modal directly on Tap
                                                      showModalBottomSheet(
                                                        context: context,
                                                        backgroundColor: Colors.transparent,
                                                        isScrollControlled: true,
                                                       builder: (context) => ServiceSelectionModal(
                                                           providerId: p.providerId,
                                                           providerCode: p.providerCode, // Pass Code
                                                           consumerId: ref.read(currentUserProvider).value?.id ?? 'unknown',
                                                           consumerName: ref.read(currentUserProvider).value?.name ?? 'User',
                                                        ),
                                                      );

                                                  },
                                                  child: Column(
                                                    children: [
                                                      const Icon(Icons.place, color: Color(0xFF3B82F6), size: 40), // Blue for available
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                        decoration: BoxDecoration(
                                                          color: Colors.black.withOpacity(0.7),
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: Text(p.providerCode, style: const TextStyle(color: Colors.white, fontSize: 10)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          return MarkerLayer(markers: markers);
                                        },
                                      ),
                                    ],
                                  ),
                                  
                                  // 2. DEPTH SHADING (Spherical Curvature)
                                  IgnorePointer(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: RadialGradient(
                                          center: Alignment.center,
                                          radius: 1.0,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.1),
                                            Colors.black.withOpacity(0.4), // Darken toward rim
                                          ],
                                          stops: const [0.0, 0.6, 1.0],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // 3. DIRECTIONAL LIGHTING (Top-Left Light Source)
                                  IgnorePointer(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: const Alignment(-0.6, -0.6),
                                          end: const Alignment(0.8, 0.8),
                                          colors: [
                                            Colors.white.withOpacity(0.08), // Highlight
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.35), // Shadow
                                          ],
                                          stops: const [0.0, 0.5, 1.0],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // 4. ATMOSPHERIC GLOW (Outer Ring)
                            IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF4A9DE8).withOpacity(0.15),
                                      blurRadius: 50,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            
            // Wide Glassmorphic Search Bar with Glow
            Positioned(
              top: 16,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              child: _buildSolidSearchBar(),
            ),

            // Incoming Call Listener Overlay
            StreamBuilder<IncomingCallEvent>(
              stream: IncomingCallListenerService().onIncomingCall,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final event = snapshot.data!;
                  final currentUser = ref.read(currentUserProvider).valueOrNull;

                  if (currentUser != null) {
                    // Show dialog on next frame to avoid build conflicts
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (context.mounted) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => IncomingCallDialog(
                            callId: event.callId,
                            callerName: event.consumerName.isNotEmpty
                                ? event.consumerName
                                : 'Unknown User',
                            senderId: event.consumerId,
                            providerId: currentUser.id,
                          ),
                        );
                      }
                    });
                  }
                }
                return const SizedBox.shrink();
              },
            ),
            
            // Bottom Navigation
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomNav(),
            ),
            
            // Location Button - Bottom right (Replaces Profile Icon)
            Positioned(
              bottom: 85,
              right: 20,
              child: _buildLocationButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSolidSearchBar() {
    // FINAL ROOT FIX: Isolated Theme, UniqueKey, Explicit Styles + Glow
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _shakeController,
          builder: (context, child) {
            final dx = sin(_shakeController.value * pi * 4) * 10;
            return Transform.translate(
              offset: Offset(dx, 0),
              child: child,
            );
          },
          child: Theme(
            data: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: Colors.transparent, // Handled by Container
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(color: Color(0xFF9AA3B2)),
              ),
            ),
            child: Container(
              // key: UniqueKey(), // Removed UniqueKey to prevent focus loss on rebuild
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF181A1F), // Solid Dark Charcoal
                borderRadius: BorderRadius.circular(100), // Full pill shape
                border: Border.all(
                  color: _providerError != null 
                      ? Colors.redAccent 
                      : const Color(0xFF3B82F6).withOpacity(0.3), // Red if error, else Blue-ish
                  width: 1.0,
                ),
                boxShadow: [
                  // Outer Glow
                  BoxShadow(
                    color: _providerError != null 
                        ? Colors.redAccent.withOpacity(0.15)
                        : const Color(0xFF3B82F6).withOpacity(0.15),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF3B82F6), // Blue Accent Icon
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        color: Color(0xFFE2E8F0), // Lighter Text
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: const Color(0xFF3B82F6),
                      decoration: const InputDecoration(
                        hintText: 'Search experts or locations',
                        // Styles inherited from local Theme above
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      onSubmitted: _handleSearch,
                      onChanged: (val) {
                         if (_providerError != null) {
                           setState(() => _providerError = null);
                         }
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
        ),
        if (_providerError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _providerError!,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _handleSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    // Direct Call Mode (Bypassing SearchProvider verification)
    // The backend SearchProvider returns "Not Found" securely for now.
    // We allow users to attempt connection if they have the code.
    
    // Pattern Check (Optional: 3+ Alphanumeric, dash, 6 digits)
    final providerRegex = RegExp(r'^[A-Za-z0-9]{3,}-\d{6}$');

    if (providerRegex.hasMatch(trimmed)) {
       // Valid Format -> Open Modal directly
       final user = ref.read(currentUserProvider).valueOrNull;
       final consumerName = user?.name ?? 'User';

       showModalBottomSheet(
         context: context,
         backgroundColor: Colors.transparent,
         isScrollControlled: true,
         builder: (context) => ServiceSelectionModal(
            providerId: '', // ID unknown in direct code search
            providerCode: trimmed, // The Code
            consumerId: user?.id ?? 'unknown',
            consumerName: consumerName,
         ),

       );
    } else {
       // Invalid Format
       setState(() => _providerError = "Invalid format (e.g. XNQ-123456)");
       _shakeController.forward(from: 0.0);
    }
  }

  Widget _buildLocationButton() {
    return Material(
      color: const Color(0xFF1A1F2E).withOpacity(0.9), // Dark button
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        onTap: () async {
          // "Locate Me" Action
          final notifier = ref.read(providerStatusProvider.notifier);
          
          // 1. Request Permission
          final hasPermission = await notifier.requestLocationPermissionIfNeeded();
          
          if (!hasPermission) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enable location permission to use this feature.'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
            return;
          }

          // 2. Fetch & Update Location (State)
          final location = await notifier.updateCurrentLocation();
          
          if (location != null) {
            _mapController.move(location, 15.0); // Zoom in to street level
          } else {
             // Fallback (e.g. GPS error)
             if (context.mounted) {
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Unable to fetch location. Check your GPS settings.')),
               );
             }
             // Optional: Center map to default just to show something
             _mapController.move(const LatLng(20.5937, 78.9629), 5.0);
          }
        },
        customBorder: const CircleBorder(),
        child: Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [
               BoxShadow(
                color: const Color(0xFF3B82F6).withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
               ),
            ],
          ),
          child: const Icon(
            Icons.my_location_rounded,
            color: Color(0xFF3B82F6), // Blue accent
            size: 26,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 80, // Slightly taller for elegance
      decoration: BoxDecoration(
        color: const Color(0xFF050508).withOpacity(0.95), // Matches space theme
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon: Icons.calendar_today_rounded, label: 'Events', isActive: false),
            _buildNavItem(icon: Icons.public_rounded, label: 'Home', isActive: true),
            _buildNavItem(
              icon: Icons.menu_rounded, 
              label: 'Menu', 
              isActive: false,
              onTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon, 
    required String label, 
    required bool isActive,
    VoidCallback? onTap,
  }) {
    final color = isActive ? const Color(0xFF3B82F6) : const Color(0xFF64748B);
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: isActive ? BoxDecoration(
            color: const Color(0xFF3B82F6).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ) : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon, 
                color: color, 
                size: 24,
                shadows: isActive ? [
                  BoxShadow(color: const Color(0xFF3B82F6).withOpacity(0.5), blurRadius: 10),
                ] : null,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. VISUAL HELPERS (PAINTERS)
// ---------------------------------------------------------------------------

class RealisticStarFieldPainter extends CustomPainter {
  final bool isInteracting;
  final Offset parallaxOffset;
  final double time;

  // Static list for performance (generated once per app run effectively if static, but here per instance)
  // To avoid regeneration, we use a fixed seed.
  static final Random _rng = Random(1337); 
  static final List<_Star> _stars = List.generate(150, (index) {
     return _Star(
       _rng.nextDouble(),
       _rng.nextDouble(),
       _rng.nextDouble(), // Size
       _rng.nextDouble(), // Brightness
       index % 3, // Layer: 0=Far, 1=Mid, 2=Near
     );
  });

  RealisticStarFieldPainter({
    required this.isInteracting,
    required this.parallaxOffset,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paints
    final paintFar = Paint()..color = Colors.white.withOpacity(0.3);
    final paintMid = Paint()..color = const Color(0xFFC4D6FF).withOpacity(0.5); // Slight blue tint
    final paintNear = Paint()..color = Colors.white.withOpacity(isInteracting ? 0.9 : 0.7); // Glows on touch

    // Glow mask for interactivity (Subtle shimmer)
    if (isInteracting) {
       final glowPaint = Paint()
         ..color = const Color(0xFF3B82F6).withOpacity(0.05)
         ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);
       canvas.drawRect(Rect.fromLTWH(0,0,size.width, size.height), glowPaint);
    }

    // Interactive Offset dampening
    // Parallax Factor: Far (0.2), Mid (0.5), Near (1.0) - deeply subtle
    // Note: We mod calculation by size to wrap stars so they don't disappear forever
    
    for (var i = 0; i < _stars.length; i++) {
      final s = _stars[i];
      Paint p;
      double sizeFactor;
      double moveFactor;

      if (s.layer == 0) {
        p = paintFar;
        sizeFactor = 0.8;
        moveFactor = 0.5;
      } else if (s.layer == 1) {
        p = paintMid;
        sizeFactor = 1.2;
        moveFactor = 1.0;
        
        // Mid stars pulse smoothly
        final pulse = sin(time * 2 + i) * 0.2 + 0.8; 
        p.color = p.color.withOpacity((0.4 * pulse).clamp(0.1, 0.8));
      } else {
        p = paintNear;
        sizeFactor = 2.0;
        moveFactor = 2.0;
        
        // Near stars interact more
        if (isInteracting) {
          sizeFactor *= 1.5; // Grow slightly on touch
        }
      }

      // Parallax Calculation with Wrap-Around
      double x = (s.x * size.width + (parallaxOffset.dx * moveFactor)) % size.width;
      double y = (s.y * size.height + (parallaxOffset.dy * moveFactor)) % size.height;
      
      // Handle negative modulo wrap
      if (x < 0) x += size.width;
      if (y < 0) y += size.height;

      canvas.drawCircle(Offset(x, y), s.size * sizeFactor, p);
    }
  }

  @override
  bool shouldRepaint(covariant RealisticStarFieldPainter oldDelegate) {
    return oldDelegate.isInteracting != isInteracting || 
           oldDelegate.parallaxOffset != parallaxOffset ||
           oldDelegate.time != time; // Repaint if animating
  }
}

class _Star {
  final double x; // 0-1
  final double y; // 0-1
  final double size; // 0-1 basemultiplier
  final double brightness;
  final int layer;

  _Star(this.x, this.y, this.size, this.brightness, this.layer);
}
