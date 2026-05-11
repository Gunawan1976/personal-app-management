import 'package:dio/dio.dart';

import '../../../../core/network/injection.dart';
import '../models/single_produk_model.dart';

abstract class SingleProdukApiServices {

  Future<SingleProduct> getSingleProduk({required String id});
}

class SingleProdukApiServiceImpl extends SingleProdukApiServices {
  Dio dio;

  SingleProdukApiServiceImpl(this.dio);

  @override
  Future<SingleProduct> getSingleProduk({required String id})async {
    return await dio.get(
      "products/$id",).then((value) async {
      return SingleProduct.fromJson(value.data);
    });
  }
}
