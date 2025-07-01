import 'package:api_cubit_task/features/home/cubit/lap_cubit.dart';
import 'package:api_cubit_task/features/home/cubit/lap_state.dart';
import 'package:api_cubit_task/features/home/view/widget/lap_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LapCubit()..getLaps(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Icon(Icons.laptop_mac, color: Colors.white, size: 26),
                    const SizedBox(width: 12),
                    const Text(
                      'Laptop Store',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {},
                        tooltip: 'Search',
                      ),
                    ),

                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<LapCubit, LapState>(
          builder: (context, state) {
            if (state is LapLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is LapLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 120),
                itemCount: state.lapList.length,
                itemBuilder: (context, index) {
                  return LapCard(laptop: state.lapList[index]);
                },
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey[50]!, Colors.white],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 80,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Something went wrong',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please try again',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
