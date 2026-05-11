import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/login_entities.dart';
import '../../../../../core/data_state.dart';
import 'login_provider.dart';
import 'login_state.dart';

final loginNotifierProvider =
AsyncNotifierProvider<LoginNotifier, DataState<LoginEntities>>(
  LoginNotifier.new,
);

class LoginNotifier extends AsyncNotifier<DataState<LoginEntities>> {
  @override
  FutureOr<DataState<LoginEntities>> build() {
    return DataSuccess(
      LoginEntities()
    ); // initial state
  }

  Future<void> login({
    required String id,
    required String password,
    required String captcha,
    required String captchaId,
    required String csrfToken,
  }) async {
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      final loginResult = await ref.read(loginUseCaseProvider).loginRepository.login(
        id: id,
        password: password,
        captcha: captcha,
        captchaId: captchaId,
        csrfToken: csrfToken,
      );

      // Simpan session SEBELUM mengupdate state loginNotifier ke success
      // agar saat listener di UI terpanggil, isAuthenticated sudah bernilai true.
      if (loginResult is DataSuccess<LoginEntities>) {
        final data = loginResult.data;
        final accessToken = data?.accessToken;
        final refreshToken = data?.refreshToken;

        if (accessToken != null && refreshToken != null) {
          await ref.read(authSessionProvider.notifier).setLogin(
            accessToken: accessToken,
            refreshToken: refreshToken,
          );
        }
      }

      return loginResult;
    });

    state = result;
  }

  Future<void> logout() async {
    await ref.read(authSessionProvider.notifier).logout();
    state = AsyncData(DataSuccess(LoginEntities()));
  }

  void reset() {
    state = AsyncData(DataSuccess(LoginEntities()));
  }
}
