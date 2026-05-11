import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login/presentation/pages/login_page.dart';
import '../../features/auth/login/presentation/providers/login_state.dart';
import '../../features/index_page.dart';
import '../../features/splash_screen.dart';

/// Class helper untuk refresh GoRouter saat stream berubah
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final goRouterProvider = Provider<GoRouter>((ref) {
  // Listen ke stream dari authSessionProvider.notifier
  // Ini akan men-trigger redirect GoRouter setiap kali state auth berubah
  final authStream = ref.watch(authSessionProvider.notifier);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: RiverpodRefreshListenable(ref, authSessionProvider),
    redirect: (context, state) {
      // Ambil state auth terbaru
      final authValue = ref.read(authSessionProvider).value;
      final isAuth = authValue?.isAuthenticated ?? false;
      
      final isLogin = state.matchedLocation == '/login';
      final isSplash = state.matchedLocation == '/splash';

      // Jangan redirect jika di splash
      if (isSplash) return null;

      // Jika belum login dan tidak di halaman login, paksa ke login
      if (!isAuth && !isLogin) return '/login';
      
      // Jika sudah login tapi masih di halaman login, paksa ke home
      if (isAuth && isLogin) return '/home';

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (c, s) => const LoginPage()),
      GoRoute(path: '/home', builder: (c, s) => const IndexPage()),
      GoRoute(path: '/splash', builder: (c, s) => const SplashScreen()),
    ],
  );
});
