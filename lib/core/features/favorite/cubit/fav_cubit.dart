import 'package:api_cubit_task/core/features/favorite/cubit/fav_state.dart';
import 'package:api_cubit_task/core/features/favorite/model/fav_data.dart';
import 'package:api_cubit_task/core/features/home/model/lap_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  addFav({required String lapId}) async {
    // إضافة العنصر لقائمة العناصر اللي بيتم إضافتها
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
      bool success = await FavoriteService.addToFav(lapId);
      if (success) {
        List<LapModel> favorites = await FavoriteService.getFavorites();
        emit(
          FavLoaded(favorites, addingItems: const {}, deletingItems: const {}),
        );
      } else {
        // في حالة الفشل، إزالة العنصر من قائمة الإضافة
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
      // في حالة الخطأ، إزالة العنصر من قائمة الإضافة
      if (state is FavLoaded) {
        final currentState = state as FavLoaded;
        final newAddingItems = Set<String>.from(currentState.addingItems);
        newAddingItems.remove(lapId);
        emit(currentState.copyWith(addingItems: newAddingItems));
      }
      emit(FavError());
    }
  }

  getFavorites() async {
    emit(FavLoading());
    try {
      List<LapModel> favorites = await FavoriteService.getFavorites();
      emit(
        FavLoaded(favorites, addingItems: const {}, deletingItems: const {}),
      );
    } catch (e) {
      print('Error in getFavorites: $e');
      emit(FavError());
    }
  }

  deleteFav({required String lapId}) async {
    // إضافة العنصر لقائمة العناصر اللي بيتم حذفها
    if (state is FavLoaded) {
      final currentState = state as FavLoaded;
      emit(
        currentState.copyWith(
          deletingItems: {...currentState.deletingItems, lapId},
        ),
      );
    }

    try {
      bool success = await FavoriteService.deleteFromFav(lapId);
      if (success) {
        // جلب القائمة المحدثة وإزالة العنصر من قائمة الحذف
        List<LapModel> favorites = await FavoriteService.getFavorites();
        emit(
          FavLoaded(favorites, addingItems: const {}, deletingItems: const {}),
        );
      } else {
        // في حالة الفشل، إزالة العنصر من قائمة الحذف
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
      // في حالة الخطأ، إزالة العنصر من قائمة الحذف
      if (state is FavLoaded) {
        final currentState = state as FavLoaded;
        final newDeletingItems = Set<String>.from(currentState.deletingItems);
        newDeletingItems.remove(lapId);
        emit(currentState.copyWith(deletingItems: newDeletingItems));
      }
      emit(FavError());
    }
  }

  // دالة للتبديل بين إضافة وحذف المفضلة
  toggleFav({required String lapId}) async {
    if (state is FavLoaded) {
      final currentState = state as FavLoaded;
      bool isFavorite = currentState.list.any((fav) => fav.id == lapId);

      if (isFavorite) {
        deleteFav(lapId: lapId);
      } else {
        addFav(lapId: lapId);
      }
    }
  }
}
