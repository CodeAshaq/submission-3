import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/restaurant_search_page.dart';
import 'package:restaurant_app/ui/restoran_list_page.dart';
import 'package:restaurant_app/widget/favorite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const RestaurantsList(),
    const RestaurantSearchPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _bottomNavBarItems() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _bottomNavIndex,
      selectedItemColor: Colors.red,
      backgroundColor: Colors.white,
      elevation: 10, //ketebalan shadow
      items: const [
        BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
      ],
      onTap: (index) {
        _onItemTapped(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Restaurant',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Tempat Makan Terbaikmu Ada disini!',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.grey),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FavoritesPage();
              }));
            },
            icon: const Icon(Icons.favorite_border),
          )
        ],
      ),
      body: _listWidget.elementAt(_bottomNavIndex),
      bottomNavigationBar: _bottomNavBarItems(),
    );
  }
}
