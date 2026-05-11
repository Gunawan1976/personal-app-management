import 'package:dio/dio.dart';
import '../../../../../core/network/injection.dart';
import '../models/login_models.dart';
import '../models/profile_model.dart';
import '../models/refresh_token_model.dart';

abstract class LoginApiServices {
  Future<LoginModel> login({
    required String id,
    required String password,
    required String captcha,
    required String captchaId,
    required String csrfToken
  });

  Future<ProfileModel> getProfile();

  Future<RefreshTokenModel>getRefreshToken({required String refreshToken});
}

class LoginApiServiceImpl extends LoginApiServices{
  Dio dio;

  LoginApiServiceImpl(this.dio);

  @override
  Future<LoginModel> login({required String id, required String password, required String captcha, required String captchaId, required String csrfToken}) async{
    return await dio.post('auth/login',
      data: {
        "username": id,
        "password":password,
        "expiresInMins": 30
      },
      options: Options(
        // same as credentials: 'include'
        extra: {"withCredentials": true},
      ),
    ).then((value) async{
      print("test isi dari ini api service: ${value.statusCode}");
      return LoginModel.fromJson(value.data);
    });
  }

  @override
  Future<ProfileModel> getProfile() async{
    return await dio.get('auth/me',
    ).then((value) async{
      return ProfileModel.fromJson(value.data);
    });
  }

  @override
  Future<RefreshTokenModel> getRefreshToken({required String refreshToken}) async{
    return await dio.post('auth/refresh',
        data: {
          "refreshToken": refreshToken,
          "expiresInMins": 30
        }
    ).then((value) async{
      return RefreshTokenModel.fromJson(value.data);
    });
  }
}
