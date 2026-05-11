
import '../../../../../core/data_state.dart';
import '../entities/login_entities.dart';
// import '../entities/logout_entities.dart';
import '../repositories/login_repositories.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  Future<DataState<LoginEntities>> login({required String id,required String password,required String captcha, required String captchaId, required String csrfToken}) async {
    return await loginRepository.login(id: id,password: password, captcha: captcha, captchaId: captchaId, csrfToken: csrfToken);
  }

}
