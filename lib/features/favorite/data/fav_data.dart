
import 'package:api_cubit_task/features/home/model/lap_model.dart';
import 'package:dio/dio.dart';

class FavoriteData {
  static final Dio dio = Dio();

  static Future<List<LapModel>> getFav() async {
    try {
      var response = await dio.get(
        "https://elwekala.onrender.com/favorite",
        data: {"nationalId": "01026524572123"},
      );

      List data = response.data['favoriteProducts'];

      List<LapModel> list = data.map((e) => LapModel.fromJson(e)).toList();
      return list;
    } catch (e) {
      print('Error getting favorites: $e');
      throw Exception(e);
    }
  }

  static Future<bool> addToFav(String productId) async {
    try {
      var response = await dio.post(
        "https://elwekala.onrender.com/favorite",
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

  static Future<bool> deleteFromFav(String productId) async {
    try {
      var response = await dio.delete(
        "https://elwekala.onrender.com/favorite",
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
}
