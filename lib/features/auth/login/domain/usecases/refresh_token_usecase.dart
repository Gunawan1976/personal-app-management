
import '../../../../../core/data_state.dart';
import '../entities/refresh_token_entities.dart';
import '../repositories/login_repositories.dart';

class GetRefreshTokenUseCase {
  final LoginRepository repository;

  GetRefreshTokenUseCase(this.repository);

  Future<DataState<RefreshTokenEntities>> call({required String refreshToken}) {
    return repository.getRefreshToken(refreshToken: refreshToken);
  }
}