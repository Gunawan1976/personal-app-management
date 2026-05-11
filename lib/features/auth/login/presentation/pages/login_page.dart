import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/data_state.dart';
import '../../../../../shared/widget/custom_text_widget.dart';
import '../../domain/entities/login_entities.dart';
import '../providers/login_notifier.dart';
import '../providers/login_provider.dart';
// import '../providers/login_ui_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  final bool? isLoginSSO;
  const LoginPage({super.key, this.isLoginSSO});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final masukanCaptchaController = TextEditingController();

  String _captchaId = '';

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    masukanCaptchaController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    ref.read(loginNotifierProvider.notifier).login(
      id: usernameController.text,
      password: passwordController.text,
      captcha: masukanCaptchaController.text,
      captchaId: _captchaId,
      csrfToken: "dummy_csrf_token",
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginNotifierProvider);
    final isPasswordVisible = ref.watch(passwordVisibleProvider);

    /// ✅ LISTEN UNTUK SUCCESS / ERROR (side effect)
    ref.listen(loginNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (dataState) {
          if (dataState is DataSuccess<LoginEntities> &&
              dataState.data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login berhasil")),
            );
            print("Login berhasil");

            context.go('/home');
          }

          if (dataState is DataFailed<LoginEntities>) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(dataState.error ?? "Login gagal")),
            );
          }
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: TextView(
          text: "Login",
          fontSize: 20.sp,
          textColor: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      body: loginState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) =>
            Center(child: Text("Unexpected error: $err")),
        data: (dataState) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ERROR TEXT
                    if (dataState is DataFailed<LoginEntities>)
                      Text(
                        dataState.error ?? "Login gagal",
                        style: const TextStyle(color: Colors.red),
                      ),

                    TextField(
                      key: const Key('textfield_username'),
                      controller: usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Masukan Username',
                      ),
                    ),

                    SizedBox(height: 25.h),

                    TextField(
                      key: const Key('textfield_password'),
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Masukan Password',
                        suffixIcon: InkWell(
                          onTap: () {
                            ref.read(passwordVisibleProvider.notifier)
                                .state = !isPasswordVisible;
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        key: const Key('button_login'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _onLoginPressed,
                        child: TextView(
                          text: 'LOGIN',
                          fontSize: 16.sp,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
