import 'package:api_cubit_task/core/features/favorite/cubit/fav_cubit.dart';
import 'package:api_cubit_task/core/features/home/view/screen/splash_sreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavCubit()..getFavorites(),
      child: MaterialApp(
        routes: {
          // 'details': (context) => const DetailsScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
