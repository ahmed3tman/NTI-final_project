

import 'package:api_cubit_task/features/cart/cubit/cart_state.dart';
import 'package:api_cubit_task/features/cart/data/cart_data.dart';
import 'package:api_cubit_task/features/cart/model/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  getCart() async {
    emit(CartLoading());

    try {
      List<CartModel> cart = await CartData.getCart();
      emit(CartLoaded(cart, addingItems: const {}, deletingItems: const {}));
    } catch (e) {
      print('Error in getCartorites: $e');
      emit(CartError());
    }
  }

  addCart({required String lapId}) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      emit(
        currentState.copyWith(
          addingItems: {...currentState.addingItems, lapId},
        ),
      );
    } else {
      emit(CartLoading());
    }

    try {
      bool success = await CartData.addToCart(productId: lapId);
      if (success) {
        List<CartModel> cart = await CartData.getCart();
        emit(CartLoaded(cart, addingItems: const {}, deletingItems: const {}));
      } else {
        if (state is CartLoaded) {
          final currentState = state as CartLoaded;
          final newAddingItems = Set<String>.from(currentState.addingItems);
          newAddingItems.remove(lapId);
          emit(currentState.copyWith(addingItems: newAddingItems));
        }
        emit(CartError());
      }
    } catch (e) {
      print('Error in addCart: $e');
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final newAddingItems = Set<String>.from(currentState.addingItems);
        newAddingItems.remove(lapId);
        emit(currentState.copyWith(addingItems: newAddingItems));
      }
      emit(CartError());
    }
  }

  deleteCart({required String lapId}) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      emit(
        currentState.copyWith(
          deletingItems: {...currentState.deletingItems, lapId},
        ),
      );
    } else {
      emit(CartLoading());
    }

    try {
      await CartData.deleteFromCart(lapId);
      List<CartModel> cart = await CartData.getCart();
      emit(CartLoaded(cart, addingItems: const {}, deletingItems: const {}));
    } catch (e) {
      print('Error in deleteCart: $e');
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final newDeletingItems = Set<String>.from(currentState.deletingItems);
        newDeletingItems.remove(lapId);
        emit(currentState.copyWith(deletingItems: newDeletingItems));
      }
      emit(CartError());
    }
  }

  updateQuantity({required String lapId, required num quantity}) async {
    final cartData = CartData();
    List<CartModel> cart = await cartData.updateQuantity(
      productId: lapId,
      quantity: quantity,
    );

    emit(CartLoaded(cart, addingItems: const {}, deletingItems: const {}));
  }
}
