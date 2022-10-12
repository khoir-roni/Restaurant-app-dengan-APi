import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/restaurant_detail.dart';
import '../models/restaurant_list.dart';
import '../models/restaurant_search.dart';

class ApiService {
  Future<RestaurantList> fetchList() async {
    const url = 'https://restaurant-api.dicoding.dev/list';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return RestaurantList.fromJson(json.decode(response.body));
        print(response.body);
      } else {
        throw Exception('tidak dapat untuk mengambil data');
      }
    } on SocketException {
      throw Exception('gagal menyambung ke server');
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantDetail> fetchDetail(String id) async {
    try {
      final url = 'https://restaurant-api.dicoding.dev/detail/$id';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return RestaurantDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load detail of restaurants');
      }
    } on SocketException {
      throw Exception('gagal menyambung ke server');
    } catch (e) {
      rethrow;
    }
  }

  Future<RestaurantSearch> searchRestaurant(String query) async {
    try {
      final url = 'https://restaurant-api.dicoding.dev/search?q=$query';
      final response = await http.get(Uri.parse(url));
      // print(response.statusCode);
      if (response.statusCode == 200) {
        // print(response.body);
        return RestaurantSearch.fromJson(json.decode(response.body));
      } else {
        throw Exception("silahkan untuk mencari yang lain");
      }
    } on SocketException {
      throw Exception('gagal menyambung ke server');
    } catch (e) {
      rethrow;
    }
  }
}
