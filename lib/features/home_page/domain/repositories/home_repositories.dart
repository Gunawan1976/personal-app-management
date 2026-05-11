

import '../../../../core/data_state.dart';
import '../entities/produk_entities.dart';

abstract class HomeRepository {
  Future<DataState<ProdukEntities>> getProduk({
    required String limit,
    required String skip,
    String? sortBy,
    String? order,
  });
}
