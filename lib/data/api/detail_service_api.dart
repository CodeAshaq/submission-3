import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class ApiServiceDetail {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _category = 'detail/';

  Future<DetailRestaurantResult> getDetailId(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _category + id));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
