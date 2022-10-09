import 'package:flutter/material.dart';
import 'package:restaurant_app_api/models/restaurant_list.dart';
import 'package:restaurant_app_api/screens/search_screen.dart';
import 'screens/home_page.dart';


import 'screens/detail_page.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: primaryColor,
                  onPrimary: Colors.black,
                  secondary: secondaryColor,
                ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ), // border button 0
            ),
            appBarTheme: const AppBarTheme(elevation: 0),
            textTheme: myTextTheme,
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          DetailScreen.routeName: (context) => DetailScreen(
                restaurantId:
                    ModalRoute.of(context)?.settings.arguments as String,
              ),
        });
  }
}
