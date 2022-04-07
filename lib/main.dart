import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/search_service_api.dart';
import 'package:restaurant_app/data/api/service_api.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_list.dart';
import 'package:restaurant_app/provider/restaurant_search.dart';

import 'package:restaurant_app/ui/home_page.dart';

import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/splash.dart';
import 'package:restaurant_app/widget/favorite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider(
            create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(
            create: (_) => SearchRestaurantProvider(apiService: ApiServiceSearch())),
      ],
      child: MaterialApp(
        title: 'Restoran App',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(color: Color(0xFFD30000), size: 30)),
        ),
        initialRoute: SplashScreenPage.routeName,
        routes: {
          SplashScreenPage.routeName: (context) => const SplashScreenPage(),
          HomePage.routeName: (context) => const HomePage(),
          FavoritesPage.routeName: (context) =>  FavoritesPage()
        },
      ),
    );
  }
}
