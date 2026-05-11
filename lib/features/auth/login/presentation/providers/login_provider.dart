import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/network/injection.dart';
import '../../data/implements/login_repository_implements.dart';
import '../../data/sources/login_api_services.dart';
import '../../domain/repositories/login_repositories.dart';
import '../../domain/usecases/login_usecases.dart';

final loginApiServiceProvider = Provider<LoginApiServices>((ref) {
  return LoginApiServiceImpl(ref.read(dioProvider));
});

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepositoryImp(
    loginApiService: ref.read(loginApiServiceProvider),
  );
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.read(loginRepositoryProvider));
});

final passwordVisibleProvider = StateProvider<bool>((ref) => false);