import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_list.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';


class FavoritesPage extends StatelessWidget {
  static const routeName = '/favorite';
  FavoritesPage({Key? key}) : super(key: key);
  late String favoritesTitle = 'Favorites';

  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
              itemBuilder: (context, index) {
                return CardRestaurant(restaurantlist: provider.favorite[index]);
              },
              itemCount: provider.favorite.length);
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(favoritesTitle),
      ),
    body: _buildList(context),
      
    );
  }
}
