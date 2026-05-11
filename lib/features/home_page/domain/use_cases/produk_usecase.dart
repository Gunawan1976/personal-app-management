
import '../../../../core/data_state.dart';
import '../entities/produk_entities.dart';
import '../repositories/home_repositories.dart';

class GetProdukUseCase {
  final HomeRepository repository;

  GetProdukUseCase(this.repository);

  Future<DataState<ProdukEntities>> call({
    required String limit,
    required String skip,
    String? sortBy,
    String? order,
  }) {
    return repository.getProduk(limit: limit, skip: skip ,sortBy: sortBy,order: order);
  }
}
