import 'package:api_cubit_task/core/features/home/model/lap_model.dart';

abstract class FavState {}

class FavInitial extends FavState {}

class FavLoaded extends FavState {
  final List<LapModel> favoriteList;

  FavLoaded(this.favoriteList);
}

class FavError extends FavState {}
