import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login/presentation/pages/login_page.dart';
import '../../features/auth/login/presentation/providers/login_state.dart';
import '../../features/index_page.dart';
import '../../features/splash_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authSessionProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isAuth = authState.value?.isAuthenticated ?? false;
      final isLogin = state.matchedLocation == '/login';
      final isSplash = state.matchedLocation == '/splash';

      if (isSplash) return null;

      if (!isAuth && !isLogin) return '/login';
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
