import 'package:api_cubit_task/core/features/favorite/model/fav_data.dart';
import 'package:api_cubit_task/core/features/home/view/screen/splash_sreen.dart';
import 'package:flutter/material.dart';

void main() {

  FavoriteService.addToFav("64666de091c71d884185b778" );
  runApp(const SplashApp());
}
