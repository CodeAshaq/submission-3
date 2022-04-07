import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/search_service_api.dart';

import 'package:restaurant_app/provider/restaurant_search.dart';
import 'package:restaurant_app/widget/card_search.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  TextEditingController controller = TextEditingController();
  String nilai = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(apiService: ApiServiceSearch()),
      child: Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
        return Scaffold(
          backgroundColor: Colors.grey,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  Positioned(
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 20,
                                color: Colors.grey.shade500.withOpacity(0.20))
                          ]),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: controller,
                        style: TextStyle(color: Colors.black.withOpacity(0.4)),
                        decoration: InputDecoration(
                          hintText: 'Silahkan cari disini',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.16)),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.black.withOpacity(0.6),
                            size: 35,
                          ),
                        ),
                        onChanged: (String query) {
                          if (query.isNotEmpty) {
                            setState(() {
                              nilai = query;
                            });
                            state.fetchAllRestaurant(nilai);
                          }
                        },
                      ),
                    ),
                  ),
                ]),
                (nilai.isEmpty)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: Center(
                          child: Icon(Icons.search_outlined,
                              size: 100, color: Colors.black.withOpacity(0.6)),
                        ),
                      )
                    : Consumer<SearchRestaurantProvider>(
                        builder: (context, state, _) {
                          if (state.state == SearchResultState.loading) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.red,
                            ));
                          } else if (state.state == SearchResultState.hasData) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.result!.restaurants.length,
                              itemBuilder: (context, index) {
                                var restauran =
                                    state.result!.restaurants[index];
                                return CardSearch(restaurant: restauran);
                              },
                            );
                          } else if (state.state == SearchResultState.noData) {
                            return Center(child: Text(state.message));
                          } else if (state.state == SearchResultState.error) {
                            return Center(child: Text(state.message));
                          } else {
                            return const Center(child: Text(''));
                          }
                        },
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
