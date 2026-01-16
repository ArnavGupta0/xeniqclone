import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:xeniqclone/features/provider/services/provider_availability_service.dart';
import 'package:xeniqclone/services/grpc_service.dart';
import 'package:xeniqclone/features/call/services/incoming_call_listener_service.dart';

enum RegistrationStatus { unregistered, registering, registered, failed }

class ProviderState {
  final RegistrationStatus registrationStatus;
  final String? providerCode;
  final String? providerId;
  final LatLng? location;
  final bool isAvailable;
  final bool hasInitialized;
  final bool isLoading;

  const ProviderState({
    this.registrationStatus = RegistrationStatus.unregistered,
    this.providerCode,
    this.providerId,
    this.location,
    this.isAvailable = false,
    this.hasInitialized = false,
    this.isLoading = false,
  });

  ProviderState copyWith({
    RegistrationStatus? registrationStatus,
    String? providerCode,
    String? providerId,
    LatLng? location,
    bool? isAvailable,
    bool? hasInitialized,
    bool? isLoading,
  }) {
    return ProviderState(
      registrationStatus: registrationStatus ?? this.registrationStatus,
      providerCode: providerCode ?? this.providerCode,
      providerId: providerId ?? this.providerId,
      location: location ?? this.location,
      isAvailable: isAvailable ?? this.isAvailable,
      hasInitialized: hasInitialized ?? this.hasInitialized,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProviderStatusNotifier extends StateNotifier<ProviderState> {
  ProviderStatusNotifier() : super(const ProviderState());

  final ProviderAvailabilityService _availabilityService = ProviderAvailabilityService();
  final IncomingCallListenerService _incomingCallListener = IncomingCallListenerService();

  static const String _storageKeyProviderCode = 'xeniq_provider_code';

  // ─────────────────────────────────────────────
  // INITIALIZATION
  // ─────────────────────────────────────────────
  Future<void> initialize(String userId) async {
    debugPrint('🟢 INIT: Initializing provider for userId=$userId');

    state = state.copyWith(providerId: userId);

    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(_storageKeyProviderCode);

    if (savedCode != null && savedCode.isNotEmpty) {
      debugPrint('✅ INIT: Loaded persisted providerCode=$savedCode');
      state = state.copyWith(
        providerCode: savedCode,
        registrationStatus: RegistrationStatus.registered,
        hasInitialized: true,
      );
    } else {
      debugPrint('⚠️ INIT: No persisted providerCode found');
      state = state.copyWith(hasInitialized: true);
    }

    _registerInBackground(userId);
  }

  // ─────────────────────────────────────────────
  // BACKGROUND REGISTRATION
  // ─────────────────────────────────────────────
  Future<void> _registerInBackground(String userId) async {
    try {
      final grpc = GrpcService();
      final reachable = await grpc.checkConnectivity();
      if (!reachable) {
        debugPrint('❌ BACKGROUND: Backend unreachable');
        return;
      }
    } catch (e) {
      debugPrint('❌ BACKGROUND: Connectivity check failed: $e');
      return;
    }

    await _ensureRegistered(userId);
  }

  // ─────────────────────────────────────────────
  // ENSURE REGISTRATION (CRITICAL)
  // ─────────────────────────────────────────────
  Future<bool> _ensureRegistered(String userId) async {
    if (state.registrationStatus == RegistrationStatus.registered &&
        state.providerCode != null &&
        state.providerCode!.isNotEmpty) {
      debugPrint('✅ ENSURE: Already registered (${state.providerCode})');
      return true;
    }

    debugPrint('📝 ENSURE: Provider not registered, calling RegisterProvider...');
    state = state.copyWith(registrationStatus: RegistrationStatus.registering);

    try {
      final grpc = GrpcService();

      final code = await _availabilityService.registerProvider(
        grpc: grpc,
        providerId: userId,
      );

      if (code == null || code.isEmpty) {
        debugPrint('❌ ENSURE: RegisterProvider returned empty code');
        state = state.copyWith(registrationStatus: RegistrationStatus.failed);
        return false;
      }

      debugPrint('✅ ENSURE: Registered with code=$code');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKeyProviderCode, code);

      state = state.copyWith(
        providerId: userId,
        providerCode: code,
        registrationStatus: RegistrationStatus.registered,
        hasInitialized: true,
      );

      return true;
    } catch (e) {
      debugPrint('❌ ENSURE: Registration failed: $e');
      state = state.copyWith(registrationStatus: RegistrationStatus.failed);
      return false;
    }
  }

  // ─────────────────────────────────────────────
  // TOGGLE AVAILABILITY (FINAL, CORRECT FLOW)
  // ─────────────────────────────────────────────
  Future<void> toggleAvailability(bool value, {String? userId}) async {
    final pid = userId ?? state.providerId;
    if (pid == null || pid.isEmpty) {
      debugPrint('❌ [TOGGLE] No providerId available');
      return;
    }
    
    state = state.copyWith(providerId: pid);

    final registered = await _ensureRegistered(pid);
    if (!registered) {
      debugPrint('❌ [TOGGLE] Registration failed, aborting');
      return;
    }

    final grpc = GrpcService();

    if (value) {
      debugPrint('🟢 [TOGGLE] Going Available (pid=$pid)');

      final pos = await Geolocator.getCurrentPosition();
      final loc = LatLng(pos.latitude, pos.longitude);

      state = state.copyWith(isAvailable: true, location: loc);

      debugPrint('📡 [TOGGLE] Calling SetAvailability(true)');
      final code = await _availabilityService.setAvailability(
        grpc: grpc,
        providerId: pid,
        isAvailable: true,
      );

      if (code != null && code.isNotEmpty) {
        debugPrint('✅ [TOGGLE] Availability ON confirmed');
        state = state.copyWith(providerCode: code);
        
        // Start listening for incoming calls
        _incomingCallListener.startListening(pid);
      } else {
        debugPrint('⚠️ [TOGGLE] Availability ON returned empty code');
      }
    } else {
      debugPrint('🔵 [TOGGLE] Going Offline (pid=$pid)');

      state = state.copyWith(isAvailable: false);

      debugPrint('📡 [TOGGLE] Calling SetAvailability(false)');
      
      // Stop listening for incoming calls before going offline
      _incomingCallListener.stopListening();
      
      final code = await _availabilityService.setAvailability(
        grpc: grpc,
        providerId: pid,
        isAvailable: false,
      );

      if (code != null && code.isNotEmpty) {
        debugPrint('✅ [TOGGLE] Availability OFF confirmed');
        state = state.copyWith(providerCode: code);
      }
    }
  }

  // ─────────────────────────────────────────────
  // LOCATION PERMISSION MANAGEMENT
  // ─────────────────────────────────────────────
  /// Request location permission if not already granted
  Future<bool> requestLocationPermissionIfNeeded() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      
      if (permission == LocationPermission.deniedForever) {
        debugPrint('❌ Location permission denied forever');
        return false;
      }
      
      if (permission == LocationPermission.denied) {
        debugPrint('❌ Location permission denied');
        return false;
      }
      
      debugPrint('✅ Location permission granted');
      return true;
    } catch (e) {
      debugPrint('❌ Permission check failed: $e');
      return false;
    }
  }

  /// Update current location and return it
  Future<LatLng?> updateCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      final location = LatLng(position.latitude, position.longitude);
      
      state = state.copyWith(location: location);
      
      debugPrint('📍 Location updated: ${location.latitude}, ${location.longitude}');
      
      return location;
    } catch (e) {
      debugPrint('❌ Failed to get location: $e');
      return null;
    }
  }
}

final providerStatusProvider =
    StateNotifierProvider<ProviderStatusNotifier, ProviderState>(
  (ref) => ProviderStatusNotifier(),
);
