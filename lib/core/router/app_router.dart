import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xeniqclone/features/auth/domain/entities/app_user.dart';
import 'package:xeniqclone/features/auth/presentation/providers/auth_provider.dart';
import 'package:xeniqclone/features/auth/presentation/screens/login_screen.dart';
import 'package:xeniqclone/features/auth/presentation/screens/name_input_screen.dart';
import 'package:xeniqclone/features/auth/presentation/screens/role_selection_screen.dart';

import 'package:xeniqclone/features/home/presentation/screens/home_screen.dart';
import 'package:xeniqclone/features/session/presentation/screens/call_screen.dart';
import 'package:xeniqclone/features/live_control/live_control_screen.dart';

// Placeholder screens
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: CircularProgressIndicator()));
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(authState),
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isLoggingIn = state.uri.toString() == '/login';
      final isSplash = state.uri.toString() == '/splash';
      final isNameInput = state.uri.toString() == '/name_input';

      if (authState.isLoading) return '/splash';

      if (!isLoggedIn) {
         return isLoggingIn ? null : '/login';
      }

      // Check if user has a name
      final user = authState.value;
      if (user != null && (user.name == null || user.name!.isEmpty)) {
        return isNameInput ? null : '/name_input';
      }

      // If logged in and on splash/login/name_input (and has name), go to home
      if (isLoggingIn || isSplash || isNameInput) {
         return '/home';
      }

      return null; // Allow navigation
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/role_selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: '/name_input',
        builder: (context, state) => const NameInputScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/call/:sessionId',
        builder: (context, state) {
          final sessionId = state.pathParameters['sessionId']!;
          final isProvider = state.uri.queryParameters['isProvider'] == 'true';
          return CallScreen(sessionId: sessionId, isProvider: isProvider);
        },
      ),
      GoRoute(
        path: '/live_control',
        builder: (context, state) {
           // Default to Consumer, LocalHost for testing
           // In real app, pass params via query or path
           return const LiveControlScreen(
             callId: 'test-call-123',
             isConsumer: true, 
             serverIp: '10.0.2.2', // Android Emulator localhost
           );
        },
      ),
    ],
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(AsyncValue<dynamic> asyncValue) {
    notifyListeners();
    // For StreamProvider AsyncValue, we can't directly subscribe
    // Instead, watch it in the provider and trigger refresh
    // This is a simplified version - notifies on creation
  }

  @override
  void dispose() {
    super.dispose();
  }
}

