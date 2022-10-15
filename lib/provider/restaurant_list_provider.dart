import 'package:flutter/material.dart';

import '../api/api_service.dart';
import '../models/restaurant_list.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchAllRestaurantList();
  }

  late RestaurantList _restaurantList;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantList get result => _restaurantList;

  ResultState get state => _state;

//bertugas melakukan proses pengambilan data dari internet
  Future<dynamic> _fetchAllRestaurantList() async {

    try {

      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.fetchList();
       print("_fetchAllRestaurantList($restaurant)");
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = restaurant;

      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }

  }
}
