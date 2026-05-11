import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'auth/login/presentation/providers/login_state.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // Tunggu status autentikasi dari provider
    final authState = await ref.read(authSessionProvider.future);

    // Delay sebentar untuk transisi splash yang mulus
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Jika sudah terautentikasi (ada access token), langsung ke IndexPage (/home)
    // Jika tidak, arahkan ke halaman Login
    if (authState.isAuthenticated) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flutter_dash,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 25),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
