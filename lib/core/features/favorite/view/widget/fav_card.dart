import 'package:api_cubit_task/core/features/cart/cubit/cart_cubit.dart';
import 'package:api_cubit_task/core/features/details/view/screen/details_screen.dart';
import 'package:api_cubit_task/core/features/favorite/cubit/fav_cubit.dart';
import 'package:api_cubit_task/core/features/favorite/cubit/fav_state.dart';
import 'package:api_cubit_task/core/features/favorite/view/widget/delete_button.dart';
import 'package:api_cubit_task/core/features/home/model/lap_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavCard extends StatefulWidget {
  const FavCard({super.key, required this.laptop});

  final LapModel laptop;

  @override
  State<FavCard> createState() => _FavCardState();
}

class _FavCardState extends State<FavCard> {
  @override
  Widget build(BuildContext context) {
    final laptop = widget.laptop;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (newContext) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.read<CartCubit>()),
                  BlocProvider.value(value: context.read<FavCubit>()),
                ],
                child: DetailsScreen(laptop: laptop),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, const Color.fromARGB(255, 148, 210, 255)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    laptop.image,
                    width: 110,
                    height: 110,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 110,
                      height: 110,
                      color: Colors.grey[200],
                      child: const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              laptop.name,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          BlocBuilder<FavCubit, FavState>(
                            builder: (context, state) {
                              return FavoriteButton(
                                laptopId: widget.laptop.id,
                                isInFavoriteScreen: true,
                              );
                            },
                          ),
                        ],
                      ),
                      Text(
                        laptop.company,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black38,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),

                      Row(
                        children: [
                          Text(
                            '\$${laptop.price.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                          ),
                          const Spacer(),
                          Text(
                            '${laptop.countInStock} in stock',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: laptop.status == 'New'
                                  ? Colors.green[100]
                                  : Colors.red[100],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              laptop.status,
                              style: TextStyle(
                                color: laptop.status == 'New'
                                    ? Colors.green[800]
                                    : Colors.red[800],
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
