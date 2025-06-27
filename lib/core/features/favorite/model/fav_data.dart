import 'package:dio/dio.dart';

Dio dio = Dio();

 addToFav(String productId) async {
  var response = await dio.post(
    "https://elwekala.onrender.com/favorite",

    data: {
      {"nationalId": "01009876567876", "productId": productId},
    },
  );

  var data = response.data;

 // print(data);

  return data;
}
