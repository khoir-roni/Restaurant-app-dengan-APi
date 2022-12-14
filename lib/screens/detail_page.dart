import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/restaurant_detail_provider.dart';
import '../models/restaurant_detail.dart';

import '../api/api_service.dart';
import '../theme/theme.dart';
import '../widgets/menu_list.dart';

import '../widgets/rating_star.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail_page';

  final String restaurantId;
  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<RestaurantDetail> _restaurantDetail;

  @override
  void initState() {
    super.initState();
    _restaurantDetail = ApiService().fetchDetail(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(
            apiService: ApiService(), id: widget.restaurantId),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
              ));
            } else if (state.state == ResultState.hasData) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  foregroundColor: Colors.black,
                  title:  Text(
                    state.result.restaurant.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                          tag: state.result.restaurant.pictureId,
                          child: Center(
                            child: Image.network(
                              "https://restaurant-api.dicoding.dev/images/small/${state.result.restaurant.pictureId}",
                              fit: BoxFit.cover,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildRatingStars(state.result.restaurant.rating),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              state.result.restaurant.name,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            const Divider(color: Colors.grey),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(state.result.restaurant.city),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text('Rating: ${state.result.restaurant.rating}'),
                              ],
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(height: 10),
                            const Text(
                              'Deskripsi',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state.result.restaurant.description,
                              style: Theme.of(context).textTheme.bodyText2,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Menu",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Food:",
                        ),
                      ),
                      MenuList(menu: state.result.restaurant.menus.foods),
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Drink:",
                        ),
                      ),
                      MenuList(menu: state.result.restaurant.menus.drinks),

                      // MenuList(restaurantElement),
                    ],
                  ),
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

      // FutureBuilder(
      //   future: _restaurantDetail,
      //   builder:
      //       (BuildContext context, AsyncSnapshot<RestaurantDetail> snapshot) {
      //     var state = snapshot.connectionState;
      //     if (state != ConnectionState.done) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else {
      //       if (snapshot.hasData) {
      //         var restaurantDetail = snapshot.data?.restaurant;
      //         return Scaffold(
      //           appBar: AppBar(
      //             title: Text(restaurantDetail!.name),
      //           ),
      //           body: SingleChildScrollView(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Hero(
      //                     tag: restaurantDetail.pictureId,
      //                     child: Center(
      //                       child: Image.network(
      //                         "https://restaurant-api.dicoding.dev/images/small/${restaurantDetail.pictureId}",
      //                         fit: BoxFit.cover,
      //                       ),
      //                     )),
      //                 Padding(
      //                   padding: const EdgeInsets.all(10),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       buildRatingStars(restaurantDetail.rating),
      //                       const SizedBox(
      //                         height: 5.0,
      //                       ),
      //                       Text(
      //                         restaurantDetail.name,
      //                         style: Theme.of(context).textTheme.headline5,
      //                       ),
      //                       const Divider(color: Colors.grey),
      //                       Row(
      //                         children: [
      //                           const Icon(
      //                             Icons.location_on_outlined,
      //                             color: Colors.black,
      //                           ),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           Text(restaurantDetail.city),
      //                         ],
      //                       ),
      //                       Row(
      //                         children: [
      //                           const Icon(Icons.star),
      //                           const SizedBox(
      //                             width: 10.0,
      //                           ),
      //                           Text('Rating: ${restaurantDetail.rating}'),
      //                         ],
      //                       ),
      //                       const Divider(color: Colors.grey),
      //                       const SizedBox(height: 10),
      //                       const Text(
      //                         'Deskripsi',
      //                         style: TextStyle(fontWeight: FontWeight.bold),
      //                       ),
      //                       const SizedBox(height: 10),
      //                       Text(
      //                         restaurantDetail.description,
      //                         style: Theme.of(context).textTheme.bodyText2,
      //                         maxLines: 4,
      //                         overflow: TextOverflow.ellipsis,
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 const Padding(
      //                   padding: EdgeInsets.all(8.0),
      //                   child: Text(
      //                     "Menu",
      //                     style: TextStyle(fontWeight: FontWeight.bold),
      //                   ),
      //                 ),
      //                 const Padding(
      //                   padding: EdgeInsets.only(left: 8),
      //                   child: Text(
      //                     "Food:",
      //                   ),
      //                 ),
      //                 MenuList(menu: restaurantDetail.menus.foods),
      //                 const Padding(
      //                   padding: EdgeInsets.only(left: 8),
      //                   child: Text(
      //                     "Drink:",
      //                   ),
      //                 ),
      //                 MenuList(menu: restaurantDetail.menus.drinks),

      //                 // MenuList(restaurantElement),
      //               ],
      //             ),
      //           ),
      //         );
      //       } else if (snapshot.hasError) {
      //         return Center(
      //           child: Material(
      //             child: Text(snapshot.error.toString()),
      //           ),
      //         );
      //       } else {
      //         return const Material(child: Text(''));
      //       }
      //     }
      //   },
      // ),
    );

    // lismenu(Menus menus) {}
  }

  // lismenu(Menus menus) {}
}
