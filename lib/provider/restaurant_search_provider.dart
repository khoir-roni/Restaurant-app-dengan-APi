import 'package:flutter/material.dart';
import '../models/restaurant_search.dart';

import '../api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  late final ApiService apiService;
  late final String query ;
  RestaurantSearchProvider({required this.query, required this.apiService}) {
    _fetchAllRestaurantSearch();
  }

  late RestaurantSearch _restaurantSearch;
  late ResultState _state;

  String _message = '';

  String get message => _message;

  RestaurantSearch get result => _restaurantSearch;

  ResultState get state => _state;

//bertugas melakukan proses pengambilan data dari internet
  Future<dynamic> _fetchAllRestaurantSearch() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(query);
      print("_fetchAllRestaurantSearch($restaurant)");
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Pencarian tidak di temukan';
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
