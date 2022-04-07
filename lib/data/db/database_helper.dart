import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorite';

//membuat table database
  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restoapp.db',
      onCreate: ((db, version) async {
        await db.execute(''' CREATE TABLE $_tblFavorite(
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating TEXT
      )''');
      }),
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

//query untuk menjalankan database dan menyimpan data
  Future<void> insertFavorite(RestaurantList restaurant) async {
    final db = await database;
    await db!.insert(_tblFavorite, restaurant.toJson());
  }

//mendapatkan seluruh data bookmark yang tersimpan
  Future<List<RestaurantList>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((res) => RestaurantList.fromJson(res)).toList();
  }

  //mencari data yang tersimpan berdasarkan url
  Future<Map> getFavoriteByUrl(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results =
        await db!.query(_tblFavorite, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

//mengahapus data bookmarks berdasarkan url
  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(_tblFavorite, where: 'id = ?', whereArgs: [id]);
  }
}