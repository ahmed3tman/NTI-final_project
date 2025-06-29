import 'package:api_cubit_task/core/features/favorite/cubit/fav_cubit.dart';
import 'package:api_cubit_task/core/features/favorite/cubit/fav_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final String laptopId;
  final bool isInFavoriteScreen;

  const FavoriteButton({
    super.key,
    required this.laptopId,
    this.isInFavoriteScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        bool isFavorite = false;
        bool isDeleting = false;
        bool isAdding = false;

        if (state is FavLoaded) {
          isFavorite = state.list.any((fav) => fav.id == laptopId);
          isDeleting = state.deletingItems.contains(laptopId);
          isAdding = state.addingItems.contains(laptopId);
        }

        bool isLoading = isDeleting || isAdding;

        return IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: isLoading
              ? null
              : () {
                  if (isInFavoriteScreen && isFavorite) {
                    // في شاشة المفضلة، نحذف من المفضلة
                    context.read<FavCubit>().deleteFav(lapId: laptopId);
                  } else {
                    // في الشاشات الأخرى، نضيف أو نحذف
                    if (isFavorite) {
                      context.read<FavCubit>().deleteFav(lapId: laptopId);
                    } else {
                      context.read<FavCubit>().addFav(lapId: laptopId);
                    }
                  }
                },
          icon: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isAdding ? Colors.red : Colors.red,
                    ),
                  ),
                )
              : Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.black26,
                  size: 28,
                ),
        );
      },
    );
  }
}
