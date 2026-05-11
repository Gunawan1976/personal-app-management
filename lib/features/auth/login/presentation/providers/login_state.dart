import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/utils/storage/secure_storage_provider.dart';

class LoginState {
  final bool isAuthenticated;
  final String? accessToken;
  final String? refreshToken;

  const LoginState({
    required this.isAuthenticated,
    this.accessToken,
    this.refreshToken,
  });
}

class LoginSessionNotifier extends AsyncNotifier<LoginState> {
  @override
  Future<LoginState> build() async {
    final storage = ref.read(userStorageProvider);
    final accessToken = await storage.getField(Constant.APP_TOKEN);
    final refreshToken = await storage.getField(Constant.REFRESH_TOKEN);
    
    return LoginState(
      isAuthenticated: accessToken != null,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<void> setLogin({required String accessToken, required String refreshToken}) async {
    final storage = ref.read(userStorageProvider);
    await storage.setField(Constant.APP_TOKEN, accessToken);
    await storage.setField(Constant.REFRESH_TOKEN, refreshToken);
    
    state = AsyncData(LoginState(
      isAuthenticated: true,
      accessToken: accessToken,
      refreshToken: refreshToken,
    ));
  }

  Future<void> logout() async {
    final storage = ref.read(userStorageProvider);
    await storage.deleteField(Constant.APP_TOKEN);
    await storage.deleteField(Constant.REFRESH_TOKEN);
    
    state = const AsyncData(LoginState(isAuthenticated: false));
  }
}

final authSessionProvider =
AsyncNotifierProvider<LoginSessionNotifier, LoginState>(
  LoginSessionNotifier.new,
);
