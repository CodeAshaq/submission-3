import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_search.dart';

class ApiServiceSearch {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<SearchRestaurantResult> getTextField(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + "search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
