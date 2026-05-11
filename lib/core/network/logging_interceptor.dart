import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/login/presentation/providers/login_state.dart';
import '../constant.dart';
import '../utils/storage/secure_storage_util.dart';
import '../utils/util_helper.dart';

class LoggingInterceptors extends Interceptor {
  final Dio dio;
  final Ref ref;

  bool _isRefreshingToken = false;

  LoggingInterceptors({
    required this.dio,
    required this.ref,
  });

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Accept'] = 'application/json';

    final token = await UserStorageWrapper().getField(Constant.APP_TOKEN);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode ?? 0;

    if (statusCode == 401 &&
        err.requestOptions.extra['retry'] != true &&
        !_isRefreshingToken) {
      _isRefreshingToken = true;
      await ref.read(authSessionProvider.notifier).logout();

      try {
        final success = await _refreshToken();

        _isRefreshingToken = false;

        if (success) {
          final newToken =
          await UserStorageWrapper().getField(Constant.APP_TOKEN);

          err.requestOptions.headers['Authorization'] =
          'Bearer $newToken';
          err.requestOptions.extra['retry'] = true;

          final response = await _retry(err.requestOptions);

          return handler.resolve(response);
        } else {
          await _forceLogout();
          return handler.reject(err);
        }
      } catch (e) {
        _isRefreshingToken = false;
        await _forceLogout();
        return handler.reject(err);
      }
    }

    return super.onError(err, handler);
  }

  // ================= HELPERS =================

  Future<void> _forceLogout() async {
    await clearUserSession();

    /// 🔥 trigger riverpod auth state
    // ref.read(loginNotifierProvider.notifier).logout();
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken =
      await UserStorageWrapper().getField(Constant.REFRESH_TOKEN);

      if (refreshToken == null || refreshToken.isEmpty) return false;

      dio.options.baseUrl = Constant.BASE_URL;

      final response = await dio.post(
        'auth/refresh',
        data: {
          "refreshToken": refreshToken,
          "expiresInMins": 30,
        },
        options: Options(responseType: ResponseType.plain),
      );

      final jsonData = json.decode(response.data);

      final accessToken = jsonData['accessToken']?.toString();
      final newRefreshToken = jsonData['refreshToken']?.toString();

      if (accessToken == null || newRefreshToken == null) return false;

      await UserSecureStorage.setField(Constant.APP_TOKEN, accessToken);
      await UserSecureStorage.setField(
          Constant.REFRESH_TOKEN, newRefreshToken);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      validateStatus: requestOptions.validateStatus,
    );

    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<void> clearUserSession() async {
    await UserSecureStorage.deleteAllField();
  }
}