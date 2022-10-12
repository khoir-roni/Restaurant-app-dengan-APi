import 'package:flutter/material.dart';
import '../models/restaurant_detail.dart';

import '../api/api_service.dart';


enum ResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  String? id ;

  RestaurantDetailProvider({required this.apiService}) {
    _fetchAllRestaurantDetail(id!);
  }

  late RestaurantDetail _restaurantDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetail get result => _restaurantDetail;

  ResultState get state => _state;

//bertugas melakukan proses pengambilan data dari internet
  Future<dynamic> _fetchAllRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.fetchDetail(id);
      if (restaurant.error == true) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
