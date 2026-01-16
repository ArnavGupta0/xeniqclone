import 'package:xeniqclone/features/home/domain/entities/provider_entity.dart';

abstract class ProviderRepository {
  Stream<List<ProviderEntity>> getActiveProviders();
  Future<void> toggleAvailability(String userId, bool isOnline);
}
