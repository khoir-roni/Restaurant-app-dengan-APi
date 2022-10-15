import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/restaurant_list_provider.dart';
import '../provider/restaurant_search_provider.dart';
import '../models/restaurant_search.dart';
import 'search_screen.dart';

import '../api/api_service.dart';
import '../models/restaurant_list.dart';
import '../theme/theme.dart';
import 'restaurant_list_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  static const String _headlineText = 'Restaurant';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) => RestaurantListProvider(apiService: ApiService()),
      child: const RestaurantListScreen(),
    ),
    const SearchScreen(),

  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.public),
      label: HomeScreen._headlineText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: SearchScreen.screenTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _listWidget[_bottomNavIndex]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
