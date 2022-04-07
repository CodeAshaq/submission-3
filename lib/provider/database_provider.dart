import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  late ResultState _state; //untuk memberitahu ke UI
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantList> _favorite = [];
  List<RestaurantList> get favorite => _favorite;

  //method unutk mendapatkan data bookmark dari database
  void _getFavorite() async {
    _favorite = await databaseHelper.getFavorite();
    if (_favorite.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'empty data';
    }
    notifyListeners();
  }

  //metode untuk menambahkan bookmark
  void addFavorite(RestaurantList restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  //metode untuk mengembalikan status bookmark dari artikel
  Future<bool> isFavorited(String id) async {
    final bookmarkedArticle = await databaseHelper.getFavoriteByUrl(id);
    return bookmarkedArticle.isNotEmpty;
  }

  //metode untuk menghapus bookmark
  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}
