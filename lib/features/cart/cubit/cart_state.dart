
import 'package:api_cubit_task/features/cart/model/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartModel> list;
  final Set<String> deletingItems;
  final Set<String> addingItems;

  CartLoaded(
    this.list, {
    this.deletingItems = const {},
    this.addingItems = const {},
  });

  CartLoaded copyWith({
    List<CartModel>? list,
    Set<String>? deletingItems,
    Set<String>? addingItems,
  }) {
    return CartLoaded(
      list ?? this.list,
      deletingItems: deletingItems ?? this.deletingItems,
      addingItems: addingItems ?? this.addingItems,
    );
  }
}

class CartError extends CartState {}
