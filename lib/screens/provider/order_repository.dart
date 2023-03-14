import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/order_model.dart';

class OrderRepository {
  static const String BASE_URL =
      "http://demo25.ninavietnam.com.vn/api/sourcefull888/api/api_cart.php";


  static final futureOrderDetailProvider = FutureProvider.autoDispose.family<OrderModel?, String>((ref, id)  async {
    final Response reponse = await Dio().get("$BASE_URL/?act=get_order_detail&id_order=$id");
    if (reponse.statusCode == 200) {
      var getData = reponse.data;
      var listOrder = OrderModel.fromJson(getData);
      return listOrder;
    }else{
      throw Exception("Error Fetching");
    }
  });

  static final futureProductForDetailProvider = FutureProvider.autoDispose.family<List<Product>?, String>((ref, id)  async {
    final Response reponse = await Dio().get("$BASE_URL/?act=list_product_order_detail&id_order=$id");
    if (reponse.statusCode == 200) {
      List<Product> listOrder = [];
      var getData = reponse.data as List;
      listOrder = getData.map((i) => Product.fromJson(i)).toList();
      return listOrder;
    }else{
      throw Exception("Error Fetching");
    }
  });
}
