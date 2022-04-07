import 'package:flutter/material.dart';

import '../data/model/restaurant_detail.dart';

class CardDetail extends StatelessWidget {
  static const routeName = '/restaurans_detail';
  final Restaurant restaurant;

  const CardDetail({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/" +
                          restaurant.pictureId,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  centerTitle: true,
                  title: const Text(
                    'RESTAURANT',
                    style: TextStyle(
                      color: Color(0xFFD30000),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  titlePadding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                ),
              )
            ];
          },
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xFFD30000),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    ('${restaurant.rating}'),
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFFD30000),
                        ),
                        Text(
                          restaurant.city,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Deskripsi',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      restaurant.description,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Menu',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Text(
                      'Food',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: restaurant.menus.foods
                            .map(
                              (food) => Container(
                                height: 25,
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey)),
                                child: Text(
                                  food.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontWeight: FontWeight.normal),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Drinks',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: restaurant.menus.drinks
                            .map(
                              (drink) => Container(
                                height: 25,
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey)),
                                child: Text(
                                  drink.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontWeight: FontWeight.normal),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Comment',
                        style: Theme.of(context).textTheme.headline6),
                    ListBody(
                      children: restaurant.customerReviews.map((review) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: Center(
                                      child: Text(
                                    review.name.characters.elementAt(0),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          review.name,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' ${review.date}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade500),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              review.review,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text('Beli'),
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xFFD30000),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Ditambahkan dengan ID: ${restaurant.id}')));
                          },
                        )),
                    // ElevatedButton(onPressed: onPressed, child: child)
                  ],
                ),
              )
            ],
          )),
    );
  }
}
