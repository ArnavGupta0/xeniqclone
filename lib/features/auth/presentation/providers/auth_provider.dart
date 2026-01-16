import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xeniqclone/core/providers/supabase_provider.dart';
import 'package:xeniqclone/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:xeniqclone/features/auth/domain/entities/app_user.dart';
import 'package:xeniqclone/features/auth/domain/repositories/auth_repository.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(ref.watch(supabaseClientProvider));
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authState(AuthStateRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
Future<AppUser?> currentUser(CurrentUserRef ref) async {
  return ref.watch(authRepositoryProvider).getCurrentUser();
}
