import 'package:flutter/material.dart';
import '../models/restaurant_list.dart';

import '../screens/detail_page.dart';
import '../theme/theme.dart';
import 'rating_star.dart';

class RestaurantCardList extends StatefulWidget {
  final restaurant;
  const RestaurantCardList({super.key, this.restaurant});

  @override
  State<RestaurantCardList> createState() => _RestaurantCardListState();
}

class _RestaurantCardListState extends State<RestaurantCardList> {
  @override
  Widget build(BuildContext context) {
    var restaurantElement = widget.restaurant;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: restaurantElement.id);
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120.0,
                        child: Text(
                          restaurantElement!.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    restaurantElement.city,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  buildRatingStars(restaurantElement.rating),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 70.0,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          restaurantElement.rating.toString(),
                          style: const TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 20.0,
            top: 15.0,
            bottom: 15.0,
            child: Hero(
              tag: restaurantElement.pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  width: 110.0,
                  image: NetworkImage(
                    "https://restaurant-api.dicoding.dev/images/small/${restaurantElement.pictureId}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
