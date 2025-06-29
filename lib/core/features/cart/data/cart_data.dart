import 'package:api_cubit_task/core/features/cart/model/cart_model.dart';
import 'package:dio/dio.dart';

class CartData {
  static final Dio dio = Dio();

  static Future<List<CartModel>> getCart() async {
    try {
      var response = await dio.get(
        "https://elwekala.onrender.com/cart/allProducts",

        data: {"nationalId": "01026524572123"},
      );

      List data = response.data['products'];

      List<CartModel> list = data.map((e) => CartModel.fromJson(e)).toList();

      return list;
    } catch (e) {
      print('Error getting favorites: $e');
      throw Exception(e);
    }
  }

  static Future<bool> addToCart({required String productId}) async {
    try {
      var response = await dio.post(
        "https://elwekala.onrender.com/cart/add",
        data: {
          "nationalId": "01026524572123",
          "productId": productId,
          "quantity": "1",
        },
      );

      var data = response.data;
      print(data);
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Error adding to favorites: $e');
      return false;
    }
  }

  static Future<bool> deleteFromCart(String productId) async {
    try {
      var response = await dio.delete(
        "https://elwekala.onrender.com/cart/delete",
        data: {"nationalId": "01026524572123", "productId": productId},
      );

      var data = response.data;
      print(data);
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Error adding to favorites: $e');
      return false;
    }
  }

  updateQuantity({required String productId, required num quantity}) async {
    try {
      var response = await dio.get(
        "https://elwekala.onrender.com/cart",

        data: {
          "nationalId": "01026524572123",
          "productId": productId,
          "quantity": quantity,
        },
      );

      List data = response.data['products'];

      List<CartModel> list = data.map((e) => CartModel.fromJson(e)).toList();

      return list;
    } catch (e) {
      print('Error getting favorites: $e');
      throw Exception(e);
    }
  }
}
