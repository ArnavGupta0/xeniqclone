import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xeniqclone/features/home/domain/entities/provider_entity.dart';
import 'package:xeniqclone/features/home/domain/repositories/provider_repository.dart';

class ProviderRepositoryImpl implements ProviderRepository {
  final SupabaseClient _supabaseClient;

  ProviderRepositoryImpl(this._supabaseClient);

  @override
  Stream<List<ProviderEntity>> getActiveProviders() {
    // Listen to changes in the 'profiles' table where role = 'provider' and is_online = true
    // Listen to changes in the 'profiles' table
    return _supabaseClient
        .from('profiles')
        .stream(primaryKey: ['id'])
        .map((data) {
          final providers = data.map((json) => ProviderEntity.fromJson(json)).toList();
          return providers.where((p) => p.isOnline && p.id != _supabaseClient.auth.currentUser?.id).toList(); // Simple client-side filter
        });
  }

  @override
  Future<void> toggleAvailability(String userId, bool isOnline) async {
    await _supabaseClient.from('profiles').update({
      'is_online': isOnline,
    }).eq('id', userId);
  }
}
