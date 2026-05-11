
import '../../../../core/data_state.dart';
import '../entities/single_produk_entities.dart';

abstract class SingleProdukRepository {
  Future<DataState<SingleProductEntities>> getSingleProduk({required String id});
}
