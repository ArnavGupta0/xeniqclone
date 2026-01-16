import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xeniqclone/core/providers/supabase_provider.dart';
import 'package:xeniqclone/features/home/data/repositories/provider_repository_impl.dart';
import 'package:xeniqclone/features/home/domain/entities/provider_entity.dart';
import 'package:xeniqclone/features/home/domain/repositories/provider_repository.dart';

part 'home_providers.g.dart';

@riverpod
ProviderRepository providerRepository(ProviderRepositoryRef ref) {
  return ProviderRepositoryImpl(ref.watch(supabaseClientProvider));
}

@riverpod
Stream<List<ProviderEntity>> activeProviders(ActiveProvidersRef ref) {
  return ref.watch(providerRepositoryProvider).getActiveProviders();
}
