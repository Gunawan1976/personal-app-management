import 'package:dio/dio.dart';

import '../../../../core/data_state.dart';
import '../../../../core/network/error_handling.dart';
import '../../domain/entities/produk_entities.dart';
import '../../domain/repositories/home_repositories.dart';
import '../models/produk_model.dart';
import '../sources/home_api_services.dart';

class HomeRepositoryImp extends HomeRepository {
  HomeApiServices homeApiServices;

  HomeRepositoryImp({required this.homeApiServices});

  @override
  Future<DataState<ProdukEntities>> getProduk({
    required String limit,
    required String skip,
    String? sortBy,
    String? order,
  }) async {
    try {
      ProdukModel response = await homeApiServices.getProduk(
          limit: limit, skip: skip,sortBy: sortBy,order: order);
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataFailed(mapDioError(e));
    } catch (e) {
      return DataFailed<ProdukEntities>('Unexpected error');
    }
  }
}
