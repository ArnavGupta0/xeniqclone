import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xeniqclone/features/provider/services/provider_availability_service.dart';
import 'package:xeniqclone/src/generated/xeniq.pb.dart';

class ProvidersListNotifier extends StateNotifier<List<ProviderStatusEvent>> {
  ProvidersListNotifier() : super([]);

  final _availabilityService = ProviderAvailabilityService();
  Timer? _pollingTimer;
  bool _isPolling = false;

  /// Starts polling for available providers every 4 seconds.
  /// Idempotent: safe to call multiple times.
  void startPolling() {
    if (_isPolling) return;
    
    _isPolling = true;
    debugPrint('📡 [PROVIDERS LIST] Starting Map Polling...');
    
    // Initial fetch
    refresh();

    // Periodic fetch
    _pollingTimer = Timer.periodic(const Duration(seconds: 4), (_) async {
      await refresh();
    });
  }

  /// Stops the polling timer.
  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    _isPolling = false;
    debugPrint('🛑 [PROVIDERS LIST] Stopped Map Polling');
  }

  /// Manually refreshes the list of available providers from the backend.
  Future<void> refresh() async {
    try {
      final providers = await _availabilityService.fetchAvailableProviders();
      
      // Update state only if mounted (Riverpod handles this via dispose, but good practice)
      if (!mounted) return;
      
      state = providers;
      // debugPrint('✅ [PROVIDERS LIST] Updated: ${providers.length} providers found');
    } catch (e) {
      debugPrint('❌ [PROVIDERS LIST] Sync Error: $e');
    }
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }
}

final providersListProvider = StateNotifierProvider<ProvidersListNotifier, List<ProviderStatusEvent>>((ref) {
  return ProvidersListNotifier();
});
