
import 'package:api_cubit_task/features/favorite/cubit/fav_state.dart';
import 'package:api_cubit_task/features/favorite/data/fav_data.dart';
import 'package:api_cubit_task/features/home/model/lap_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  getFavorites() async {
    emit(FavLoading());

    try {
      List<LapModel> favorites = await FavoriteData.getFav();
      emit(
        FavLoaded(favorites, addingItems: const {}, deletingItems: const {}),
      );
    } catch (e) {
      print('Error in getFavorites: $e');
      emit(FavError());
    }
  }

  addFav({required String lapId}) async {
    if (state is FavLoaded) {
      final currentState = state as FavLoaded;
      emit(
        currentState.copyWith(
          addingItems: {...currentState.addingItems, lapId},
        ),
      );
    } else {
      emit(FavLoading());
    }

    try {
      bool success = await FavoriteData.addToFav(lapId);
      if (success) {
        List<LapModel> favorites = await FavoriteData.getFav();
        emit(
          FavLoaded(favorites, addingItems: const {}, deletingItems: const {}),
        );
      } else {
        if (state is FavLoaded) {
          final currentState = state as FavLoaded;
          final newAddingItems = Set<String>.from(currentState.addingItems);
          newAddingItems.remove(lapId);
          emit(currentState.copyWith(addingItems: newAddingItems));
        }
        emit(FavError());
      }
    } catch (e) {
      print('Error in addFav: $e');
      if (state is FavLoaded) {
        final currentState = state as FavLoaded;
        final newAddingItems = Set<String>.from(currentState.addingItems);
        newAddingItems.remove(lapId);
        emit(currentState.copyWith(addingItems: newAddingItems));
      }
      emit(FavError());
    }
  }

  deleteFav({required String lapId}) async {
    if (state is FavLoaded) {
      final currentState = state as FavLoaded;
      emit(
        currentState.copyWith(
          deletingItems: {...currentState.deletingItems, lapId},
        ),
      );
    }

    try {
      bool success = await FavoriteData.deleteFromFav(lapId);
      if (success) {
        List<LapModel> favorites = await FavoriteData.getFav();
        emit(
          FavLoaded(favorites, addingItems: const {}, deletingItems: const {}),
        );
      } else {
        if (state is FavLoaded) {
          final currentState = state as FavLoaded;
          final newDeletingItems = Set<String>.from(currentState.deletingItems);
          newDeletingItems.remove(lapId);
          emit(currentState.copyWith(deletingItems: newDeletingItems));
        }
        emit(FavError());
      }
    } catch (e) {
      print('Error in deleteFav: $e');
      if (state is FavLoaded) {
        final currentState = state as FavLoaded;
        final newDeletingItems = Set<String>.from(currentState.deletingItems);
        newDeletingItems.remove(lapId);
        emit(currentState.copyWith(deletingItems: newDeletingItems));
      }
      emit(FavError());
    }
  }
}
