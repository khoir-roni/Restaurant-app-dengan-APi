import 'package:flutter/material.dart';
import 'package:restaurant_app_api/models/restaurant_search.dart';

import '../api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  String? query;
  RestaurantSearchProvider({required this.apiService}) {
    _fetchAllRestaurantSearch(query);
  }

  late RestaurantSearch _restaurantSearch;
  late ResultState _state;

  String _message = '';

  String get message => _message;

  RestaurantSearch get result => _restaurantSearch;

  ResultState get state => _state;

//bertugas melakukan proses pengambilan data dari internet
  Future<dynamic> _fetchAllRestaurantSearch(String? query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(query!);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearch = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
