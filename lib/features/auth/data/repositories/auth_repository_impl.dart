import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xeniqclone/features/auth/domain/entities/app_user.dart';
import 'package:xeniqclone/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabaseClient;

  AuthRepositoryImpl(this._supabaseClient);

  @override
  Stream<AppUser?> get authStateChanges {
    return _supabaseClient.auth.onAuthStateChange.asyncMap((event) async {
      final session = event.session;
      if (session == null) return null;
      return await _getUserProfile(session.user.id, session.user.email ?? '');
    });
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) return null;
    return await _getUserProfile(user.id, user.email ?? '');
  }

  Future<AppUser> _getUserProfile(String userId, String email) async {
    // OPTION B: Use User Metadata (Cleaner, no extra table setup required locally)
    final user = _supabaseClient.auth.currentUser;
    if (user == null) {
      return AppUser(id: userId, email: email, name: null, role: null);
    }
    
    final metadata = user.userMetadata;
    final name = metadata?['name'] as String?;
    final roleStr = metadata?['role'] as String?;
    final role = roleStr != null 
        ? UserRole.values.firstWhere((e) => e.name == roleStr, orElse: () => UserRole.consumer) 
        : null;

    return AppUser(id: userId, email: email, name: name, role: role);
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    await _supabaseClient.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signUpWithEmail(String email, String password) async {
    await _supabaseClient.auth.signUp(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  @override
  Future<void> updateUserRole(String userId, UserRole role) async {
    await _supabaseClient.auth.updateUser(
      UserAttributes(data: {'role': role.name}),
    );
  }

  @override
  Future<void> updateUserName(String userId, String name) async {
    await _supabaseClient.auth.updateUser(
      UserAttributes(data: {'name': name}),
    );
  }
}
