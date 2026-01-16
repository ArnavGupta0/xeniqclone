import 'dart:async';
import 'dart:developer';
import 'package:fixnum/fixnum.dart';

import 'package:xeniqclone/services/grpc_service.dart';
import 'package:xeniqclone/src/generated/xeniq.pbgrpc.dart';

class ProviderGrpcService {
  static final ProviderGrpcService _instance = ProviderGrpcService._internal();
  factory ProviderGrpcService() => _instance;
  ProviderGrpcService._internal();

  final ProviderServiceClient _client = GrpcService().providerClient;
  
  /// Registers the provider without setting them available (for App Start).
  Future<void> registerSilently(String providerId, String providerCode) async {
    log('Silently Registering Provider: $providerId');
    try {
      final regRequest = RegisterProviderRequest(
        providerId: providerId,
        providerCode: providerCode,
        latitude: 0,
        longitude: 0,
      );
      await _client.registerProvider(regRequest);
    } catch (e) {
      log('Silent Registration Error: $e');
      // Don't rethrow, strictly silent
    }
  }

  /// Registers the provider and sets availability.
  /// Replaces old stream logic for persistence.
  Future<void> startStatusStream(String providerId, String providerCode) async {
    log('Registering Provider: $providerId ($providerCode)');
    
    try {
      // 1. Register (Idempotent)
      await registerSilently(providerId, providerCode);
      log('Provider Registered');

      // 2. Set Available
      await updateStatus(
        providerId: providerId, 
        providerCode: providerCode, 
        isAvailable: true,
      );
      
    } catch (e) {
      log('Failed to register provider: $e');
      rethrow;
    }
  }

  Future<void> updateStatus({
    required String providerId,
    required String providerCode,
    required bool isAvailable,
    double latitude = 0,
    double longitude = 0,
  }) async {
     try {
       final req = SetAvailabilityRequest(
         providerId: providerId,
         isAvailable: isAvailable,
       );
       await _client.setAvailability(req);
       log('Provider Status Updated: $isAvailable');
     } catch (e) {
       log('Failed to update status: $e');
     }
  }

  Future<void> stopStatusStream({String? providerId, String? providerCode}) async {
    if (providerId != null && providerCode != null) {
      await updateStatus(
        providerId: providerId,
        providerCode: providerCode,
        isAvailable: false,
      );
    }
    log('Provider Service: Stopped (Status set to Offline)');
  }
  
  /// List all available providers (for the Map).
  Future<List<ProviderStatusEvent>> listProviders() async {
    try {
      final response = await _client.listProviders(ListProvidersRequest());
      return response.providers;
    } catch (e) {
      log('List Provider Error: $e');
      return [];
    }
  }

  /// Searches for a provider by code.
  Future<SearchResponse> searchProvider(String code) async {
    try {
      final request = SearchRequest(providerCode: code);
      return await _client.searchProvider(request);
    } catch (e) {
      log('Search Provider Error: $e');
      return SearchResponse(success: false, message: 'Connection Error');
    }
  }
}
