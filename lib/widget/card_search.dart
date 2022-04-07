import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/ui/restoran_detail_page.dart';




class CardSearch extends StatelessWidget {
  
  final Restaurant restaurant;
  const CardSearch({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            leading: Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/medium/" +
                    restaurant.pictureId,
                    fit: BoxFit.cover,
                width: 100,
              ),
            ),
            title: Text(
              restaurant.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(restaurant.city),
            trailing: Text('${restaurant.rating}'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RestoranDetailPage(idRestaurant: restaurant.id);
              }));
            }),
      ),
    );
  }
}
