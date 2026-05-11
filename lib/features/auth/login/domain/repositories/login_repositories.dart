
import '../../../../../core/data_state.dart';
import '../entities/login_entities.dart';
import '../entities/profile_entities.dart';
import '../entities/refresh_token_entities.dart';

abstract class LoginRepository {
  Future<DataState<LoginEntities>> login({required String id,required String password,required String captcha,required String captchaId, required String csrfToken});
  Future<DataState<ProfileEntities>>getProfile();
  Future<DataState<RefreshTokenEntities>>getRefreshToken({required String refreshToken});
}
