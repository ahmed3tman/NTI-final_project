import 'package:api_cubit_task/core/features/favorite/cubit/fav_state.dart';
import 'package:api_cubit_task/core/features/home/model/lap_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  final List<LapModel> _favoriteList = [];

  List<LapModel> get favoriteList => _favoriteList;

  void addFav(LapModel lapModel) {
    if (!_favoriteList.any((item) => item.id == lapModel.id)) {
      _favoriteList.add(lapModel);
      emit(FavLoaded(_favoriteList));
    }
  }

  void removeFav(LapModel lapModel) {
    _favoriteList.removeWhere((item) => item.id == lapModel.id);
    if (_favoriteList.isEmpty) {
      emit(FavInitial());
    } else {
      emit(FavLoaded(_favoriteList));
    }
  }

  bool isFavorite(String id) {
    return _favoriteList.any((item) => item.id == id);
  }

  void toggleFav(LapModel lapModel) {
    if (isFavorite(lapModel.id)) {
      removeFav(lapModel);
    } else {
      addFav(lapModel);
    }
  }
}
