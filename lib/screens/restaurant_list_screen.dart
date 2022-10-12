import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/provider/restaurant_list_provider.dart';
import '../api/api_service.dart';
import '../models/restaurant_list.dart';
import '../widgets/restaurant_card_list.dart';
import '../theme/theme.dart';

import 'detail_page.dart';
import '../widgets/rating_star.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  late Future<RestaurantList> _restaurantList;

  @override
  void initState() {
    super.initState();
    _restaurantList = ApiService().fetchList();
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return RestaurantCardList(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  @override
  Widget _build(BuildContext context) {
    return FutureBuilder(
      future: _restaurantList,
      builder: (context, AsyncSnapshot<RestaurantList> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.restaurants.length,
              itemBuilder: (context, index) {
                var error = snapshot.data?.error;
                var restaurant = snapshot.data?.restaurants[index];
                if (error == true) {
                  return const Center(
                      child: Text('tidak bisa menampilkan data'));
                } else {
                  return RestaurantCardList(restaurant: restaurant);
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Material(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return const Material(
              child: Text('coba'),
            );
          }
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Restaurant',
                  style: Theme.of(context).textTheme.headline2,
                ),
                const Text(
                  'Recommendation restaurant for you!',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: _buildList(context),
            )
          ],
        ),
      ),
    );
  }
}
