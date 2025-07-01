
import 'package:api_cubit_task/features/favorite/cubit/fav_cubit.dart';
import 'package:api_cubit_task/features/favorite/cubit/fav_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatefulWidget {
  final String laptopId;
  final bool isInFavoriteScreen;

  const FavoriteButton({
    super.key,
    required this.laptopId,
    this.isInFavoriteScreen = false,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _wasAdding = false;
  bool _wasDeleting = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavCubit, FavState>(
      listener: (context, state) {
        if (state is FavLoaded) {
          if (_wasAdding && !state.addingItems.contains(widget.laptopId)) {
            _wasAdding = false;
          } else if (state.addingItems.contains(widget.laptopId)) {
            _wasAdding = true;
          }

          if (_wasDeleting && !state.deletingItems.contains(widget.laptopId)) {
            _wasDeleting = false;
          } else if (state.deletingItems.contains(widget.laptopId)) {
            _wasDeleting = true;
          }
        } else if (state is FavError) {
          if (_wasAdding || _wasDeleting) {
            _wasAdding = false;
            _wasDeleting = false;
          }
        }
      },

      child: BlocBuilder<FavCubit, FavState>(
        builder: (context, state) {
          bool isFavorite = false;
          bool isDeleting = false;
          bool isAdding = false;

          if (state is FavLoaded) {
            isFavorite = state.list.any((fav) => fav.id == widget.laptopId);
            isDeleting = state.deletingItems.contains(widget.laptopId);
            isAdding = state.addingItems.contains(widget.laptopId);
          }

          bool isLoading = isDeleting || isAdding;

          return IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: isLoading
                ? null
                : () {
                    HapticFeedback.lightImpact(); // Add haptic feedback
                    if (widget.isInFavoriteScreen && isFavorite) {
                      context.read<FavCubit>().deleteFav(
                        lapId: widget.laptopId,
                      );
                    } else {
                      if (isFavorite) {
                        context.read<FavCubit>().deleteFav(
                          lapId: widget.laptopId,
                        );
                      } else {
                        context.read<FavCubit>().addFav(lapId: widget.laptopId);
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
      ),
    );
  }
}
