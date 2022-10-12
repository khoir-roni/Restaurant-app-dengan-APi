import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant_search.dart';
import '../provider/restaurant_search_provider.dart';
import '../widgets/search_tab.dart';

import '../api/api_service.dart';
import '../widgets/restaurant_card_list.dart';

class SearchScreen extends StatefulWidget {
  static const screenTitle = "searchScreen";

  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  late Future<RestaurantSearch> _restaurantSearch;

  @override
  void initState() {
    super.initState();
    _restaurantSearch = ApiService().searchRestaurant(query);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearch(),
        Expanded(child: _build(context)),
      ],
    );
  }

  Widget _buildSearch() {
    return SearchTab(
      text: query,
      hintText: 'Nama Restaurant',
      onChanged: _SearchRestaurants,
    );
  }

  Future _SearchRestaurants(String query) async {
    _restaurantSearch = ApiService().searchRestaurant(query);
    if (!mounted) return;

    setState(() {
      this.query = query;
    });
  }



  Widget _build(BuildContext context) {
    return FutureBuilder(
      future: _restaurantSearch,
      builder: (context, AsyncSnapshot<RestaurantSearch> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            if (snapshot.data?.founded == 0) {
              return const Center(
                child: Text('silahkan cari yang lain'),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data?.restaurants[index];

                return RestaurantCardList(restaurant: restaurant);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Material(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return const Material(child: Text('Coba cari yang lain'));
          }
        }
      },
    );
  }
}
