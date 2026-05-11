import 'package:dio/dio.dart';


import '../../../../../core/data_state.dart';
import '../../../../../core/network/error_handling.dart';
import '../../domain/entities/login_entities.dart';
import '../../domain/entities/profile_entities.dart';
import '../../domain/entities/refresh_token_entities.dart';
import '../models/login_models.dart';
import '../models/profile_model.dart';
import '../models/refresh_token_model.dart';
import '../sources/login_api_services.dart';
import '../../domain/repositories/login_repositories.dart';

class LoginRepositoryImp extends LoginRepository {
  LoginApiServices loginApiService;

  LoginRepositoryImp({required this.loginApiService});

  @override
  Future<DataState<LoginEntities>> login(
      {required String id,
      required String password,
      required String captcha,
      required String captchaId,
        required String csrfToken
      }) async {
    try {
      LoginModel response = await loginApiService.login(
          id: id,
          password: password,
          captcha: captcha,
          captchaId: captchaId, csrfToken: csrfToken);
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataFailed(mapDioError(e));
    }catch (e) {
      return DataFailed<LoginEntities>('Unexpected error');
    }
  }

  @override
  Future<DataState<ProfileEntities>> getProfile()async {
    try {
      ProfileModel response = await loginApiService.getProfile(
         );
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataFailed(mapDioError(e));
    }catch (e) {
      return DataFailed<ProfileEntities>('Unexpected error');
    }
  }

  @override
  Future<DataState<RefreshTokenEntities>> getRefreshToken({required String refreshToken}) async{
    try {
      RefreshTokenModel response = await loginApiService.getRefreshToken(
        refreshToken: refreshToken
      );
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataFailed(mapDioError(e));
    }catch (e) {
      return DataFailed<RefreshTokenEntities>('Unexpected error');
    }
  }
}
