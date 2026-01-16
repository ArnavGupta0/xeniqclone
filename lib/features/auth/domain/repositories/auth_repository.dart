import 'package:xeniqclone/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  Stream<AppUser?> get authStateChanges;
  Future<AppUser?> getCurrentUser();
  Future<void> signInWithEmail(String email, String password);
  Future<void> signUpWithEmail(String email, String password);
  Future<void> signOut();
  Future<void> updateUserRole(String userId, UserRole role);
  Future<void> updateUserName(String userId, String name);
}
