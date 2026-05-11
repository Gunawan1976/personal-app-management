import '../../../../../core/data_state.dart';
import '../entities/profile_entities.dart';
import '../repositories/login_repositories.dart';

class GetProfileUseCase {
  final LoginRepository repository;

  GetProfileUseCase(this.repository);

  Future<DataState<ProfileEntities>> call() {
    return repository.getProfile();
  }
}
