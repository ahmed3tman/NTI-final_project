import 'package:api_cubit_task/core/features/favorite/cubit/fav_cubit.dart';
import 'package:api_cubit_task/core/features/favorite/view/screen/favorite_screen.dart';
import 'package:api_cubit_task/core/features/home/view/screen/home_screen.dart';
import 'package:api_cubit_task/core/features/profile/view/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => FavCubit())],
      child: Scaffold(
        body: BottomBar(
          borderRadius: BorderRadius.circular(30),
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
          showIcon: true,
          width: MediaQuery.of(context).size.width * 0.9,
          barColor: Colors.transparent,
          start: 2,
          end: 0,
          offset: 0,
          barAlignment: Alignment.bottomCenter,
          iconHeight: 35,
          iconWidth: 35,
          reverse: false,
          hideOnScroll: true,
          scrollOpposite: false,
          onBottomBarHidden: () {},
          onBottomBarShown: () {},
          body: (context, controller) =>
              TabBarView(controller: _tabController, children: _screens),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorSize: TabBarIndicatorSize.tab,
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              dividerColor: Colors.transparent,
              labelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(icon: Icon(Icons.home_outlined, size: 24), text: 'Home'),
                Tab(
                  icon: Icon(Icons.favorite_border, size: 24),
                  text: 'Favorites',
                ),
                Tab(
                  icon: Icon(Icons.person_outline, size: 24),
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
