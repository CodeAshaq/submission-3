

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/detail_service_api.dart';
import 'package:restaurant_app/provider/restaurant_detail.dart';
import 'package:restaurant_app/widget/detail_restaurat.dart';

class RestoranDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String idRestaurant;
  const RestoranDetailPage({Key? key, required this.idRestaurant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: ChangeNotifierProvider<DetailRestaurantProvider>(
        create: (_) =>
            DetailRestaurantProvider(apiService: ApiServiceDetail(), id: idRestaurant),
        child: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == DetailResultState.loading) {
              return const Center(child: CircularProgressIndicator(color: Colors.red,));
            } else if (state.state == DetailResultState.hasData) {
              final restaurants = state.result.restaurants;
              return CardDetail(
                restaurant: restaurants,
              );
            } else if (state.state == DetailResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == DetailResultState.error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
