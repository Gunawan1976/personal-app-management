import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant.dart';
import 'logging_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final options = BaseOptions(
    connectTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(minutes: 1),
    baseUrl: Constant.BASE_URL,
  );

  final dio = Dio(options);

  dio.httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () {
      final client = HttpClient(
        context: SecurityContext(withTrustedRoots: false),
      );
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    },
    validateCertificate: (certificate, host, port) => true,
  );

  dio.interceptors.add(
    LoggingInterceptors(
      dio: dio,
      ref: ref, // 🔥 penting supaya bisa logout via AuthNotifier
    ),
  );

  return dio;
});