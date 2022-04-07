import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/ui/restoran_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  
  final RestaurantList restaurantlist;

  const CardRestaurant({Key? key, required this.restaurantlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (((context, provider, _) {
        return FutureBuilder<bool>(
            future: provider.isFavorited(restaurantlist.id),
            builder: (context, snapshot) {
              var isFavorited = snapshot.data ?? false;
              return Material(
                color: primaryColor,
                child: Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      leading: Hero(
                        tag: restaurantlist.pictureId,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Image.network(
                            "https://restaurant-api.dicoding.dev/images/medium/" +
                                restaurantlist.pictureId,
                            fit: BoxFit.cover,
                            width: 100,
                          ),
                        ),
                      ),
                      title: Text(
                        restaurantlist.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(restaurantlist.city),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(
                                '${restaurantlist.rating}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: isFavorited
                          ? IconButton(
                              icon: const Icon(Icons.favorite),
                              color: Theme.of(context).colorScheme.secondary,
                              onPressed: () =>
                                  provider.removeFavorite(restaurantlist.id),
                            )
                          : IconButton(
                              onPressed: () => provider.addFavorite(restaurantlist),
                              icon: const Icon(Icons.favorite_border),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RestoranDetailPage(
                              idRestaurant: restaurantlist.id);
                        }));
                      }),
                ),
              );
            });
      })),
    );
  }
}
