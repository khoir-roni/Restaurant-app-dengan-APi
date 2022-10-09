import 'package:flutter/material.dart';
import 'package:restaurant_app_api/api/api_service.dart';
import 'package:restaurant_app_api/models/restaurant_list.dart';
import 'package:restaurant_app_api/widgets/restauran_card_list.dart';
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
            return const Material(child: Text(''));
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
              child: _build(context),
            )
          ],
        ),
      ),
    );
  }
}
