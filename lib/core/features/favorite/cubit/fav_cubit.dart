import 'package:api_cubit_task/core/features/favorite/cubit/fav_state.dart';
import 'package:api_cubit_task/core/features/favorite/model/fav_data.dart';
import 'package:api_cubit_task/core/features/home/model/lap_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  toggleFav({required String lapId}) async {
    emit(FavLoading());
    try {
      bool success = await FavoriteService.addToFav(lapId);
      if (success) {
        // After successfully adding to favorites, get the updated list
        List<LapModel> favorites = await FavoriteService.getFavorites();
        emit(FavLoaded(favorites));
      } else {
        emit(FavError());
      }
    } catch (e) {
      print('Error in toggleFav: $e');
      emit(FavError());
    }
  }

  getFavorites() async {
    emit(FavLoading());
    try {
      List<LapModel> favorites = await FavoriteService.getFavorites();
      emit(FavLoaded(favorites));
    } catch (e) {
      print('Error in getFavorites: $e');
      emit(FavError());
    }
  }
}
