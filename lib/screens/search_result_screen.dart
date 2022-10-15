import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/theme/theme.dart';
import '../api/api_service.dart';
import '../provider/restaurant_search_provider.dart';
import '../widgets/restaurant_card_list.dart';

import '../models/restaurant_search.dart';
import 'detail_page.dart';

class SearchResultScreen extends StatelessWidget {
  static const routeName = '/search_result_screen';

  final String query;

  const SearchResultScreen({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Restaurant',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ChangeNotifierProvider<RestaurantSearchProvider>(
        create: (_) =>
            RestaurantSearchProvider(apiService: ApiService(), query: query),
        child: Consumer<RestaurantSearchProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  primaryColor
                ),
              ));
            } else if (state.state == ResultState.hasData) {
              return
                 SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'restaurant Yang ditemukan: ${state.result.founded.toString()}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.result.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant = state.result.restaurants[index];
                          return RestaurantCardList(restaurant: restaurant);
                        },
                      )
                    ],
                  ),
                );

            } else if (state.state == ResultState.noData) {
              return Center(
                child: Material(
                  child: Scaffold(
                    body: Center(
                      child: Text(state.message),
                    ),
                  ),
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Material(
                  child: Scaffold(
                    body: Center(
                      child: Text(state.message),
                    ),
                  ),
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
        ),
      ),
    );
  }
}
