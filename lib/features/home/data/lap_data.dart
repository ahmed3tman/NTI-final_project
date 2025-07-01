import 'package:api_cubit_task/features/home/model/lap_model.dart';
import 'package:dio/dio.dart';

Dio dio = Dio();

Future<List<LapModel>> getLapData() async {
  var response = await dio.get("https://elwekala.onrender.com/product/Laptops");

  List data = response.data['product'];

  List<LapModel> list = data.map((e) => LapModel.fromJson(e)).toList();
  return list;
}



