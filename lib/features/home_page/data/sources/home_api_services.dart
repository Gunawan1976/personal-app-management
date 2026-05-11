import 'package:dio/dio.dart';

import '../../../../core/network/injection.dart';
import '../models/produk_model.dart';

abstract class HomeApiServices {
  Future<ProdukModel> getProduk({
    required String limit,
    required String skip,
    String? sortBy,
    String? order,
  });
}

class HomeApiServiceImpl extends HomeApiServices {
  Dio dio;

  HomeApiServiceImpl(this.dio);

  @override
  Future<ProdukModel> getProduk({
    required String limit,
    required String skip,
    String? sortBy,
    String? order,
  })async {
    Map<String, dynamic> queryParams = {
      "limit": limit,
      "skip":skip,
      "sortBy":sortBy,
      "order":order,
    };
    queryParams.removeWhere((key, value) => value == null || value == '');
    return await dio.get(
        "products",
        queryParameters:queryParams).then((value) async {
      return ProdukModel.fromJson(value.data);
    });
  }
}
