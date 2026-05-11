import 'package:dio/dio.dart';

import '../../../../core/data_state.dart';
import '../../../../core/network/error_handling.dart';
import '../../domain/entities/single_produk_entities.dart';
import '../../domain/repositories/single_produk_repositories.dart';
import '../models/single_produk_model.dart';
import '../sources/single_produk_api_services.dart';

class SingleProdukRepositoryImpl extends SingleProdukRepository {
  SingleProdukApiServices singleProdukApiServices;

  SingleProdukRepositoryImpl({required this.singleProdukApiServices});

  @override
  Future<DataState<SingleProductEntities>> getSingleProduk({required String id})async {
    try {
      SingleProduct response = await singleProdukApiServices.getSingleProduk(id: id);
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataFailed(mapDioError(e));
    } catch (e) {
      return DataFailed<SingleProductEntities>('Unexpected error');
    }
  }
}