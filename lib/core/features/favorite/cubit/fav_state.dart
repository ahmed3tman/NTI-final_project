import 'package:api_cubit_task/core/features/home/model/lap_model.dart';

abstract class FavState {}

class FavInitial extends FavState {}

class FavLoading extends FavState {}

class FavLoaded extends FavState {
  final List<LapModel> list;
  final Set<String> deletingItems; // قائمة العناصر اللي بيتم حذفها
  final Set<String> addingItems; // قائمة العناصر اللي بيتم إضافتها

  FavLoaded(
    this.list, {
    this.deletingItems = const {},
    this.addingItems = const {},
  });

  // دالة لإنشاء نسخة جديدة مع تعديل العناصر اللي بيتم حذفها أو إضافتها
  FavLoaded copyWith({
    List<LapModel>? list,
    Set<String>? deletingItems,
    Set<String>? addingItems,
  }) {
    return FavLoaded(
      list ?? this.list,
      deletingItems: deletingItems ?? this.deletingItems,
      addingItems: addingItems ?? this.addingItems,
    );
  }
}

class FavError extends FavState {}
