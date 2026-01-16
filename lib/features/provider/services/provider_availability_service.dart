import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:xeniqclone/services/grpc_service.dart';
import 'package:xeniqclone/src/generated/xeniq.pbgrpc.dart';

/// IMPORTANT:
/// - This service is PASSIVE
/// - It does NOT create gRPC clients
/// - It NEVER auto-triggers availability
/// - It is only called explicitly by ProviderStatusNotifier
class ProviderAvailabilityService {
  ProviderAvailabilityService();

  /// Registers the provider and returns the permanent providerCode
  Future<String?> registerProvider({
    required GrpcService grpc,
    required String providerId,
    double latitude = 0,
    double longitude = 0,
  }) async {
    try {
      debugPrint('📤 [REGISTER] Sending RegisterProvider for $providerId');

      final req = RegisterProviderRequest(
        providerId: providerId,
        latitude: latitude,
        longitude: longitude,
      );

      final response = await grpc.providerClient.registerProvider(req);

      debugPrint('📥 [REGISTER] Success=${response.success} Code=${response.providerCode}');

      return response.success && response.providerCode.isNotEmpty
          ? response.providerCode
          : null;
    } catch (e) {
      debugPrint('❌ [REGISTER] Error: $e');
      return null;
    }
  }

  /// Sets provider availability
  Future<String?> setAvailability({
    required GrpcService grpc,
    required String providerId,
    required bool isAvailable,
  }) async {
    debugPrint('📡 [AVAILABILITY] Request → ID=$providerId Available=$isAvailable');

    try {
      final req = SetAvailabilityRequest(
        providerId: providerId,
        isAvailable: isAvailable,
      );

      final response = await grpc.providerClient.setAvailability(req);

      debugPrint(
        '📡 [AVAILABILITY] Response → Success=${response.success} Code=${response.providerCode}',
      );

      return response.success && response.providerCode.isNotEmpty
          ? response.providerCode
          : null;
    } catch (e) {
      debugPrint('❌ [AVAILABILITY] Error: $e');
      return null;
    }
  }

  /// Fetch available providers (consumer map)
  Future<List<ProviderStatusEvent>> fetchAvailableProviders({
    GrpcService? grpc,
  }) async {
    try {
      final service = grpc ?? GrpcService();
      final response =
          await service.providerClient.listProviders(ListProvidersRequest());
      return response.providers;
    } catch (e) {
      debugPrint('❌ [FETCH] Providers Error: $e');
      return [];
    }
  }
}
