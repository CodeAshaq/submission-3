import 'dart:async';
import 'dart:io';
import 'package:restaurant_app/data/api/search_service_api.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:flutter/material.dart';

enum SearchResultState { loading, noData, hasData, error }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiServiceSearch apiService;

  SearchRestaurantProvider({required this.apiService}) {
    fetchAllRestaurant(search);
  }

  SearchRestaurantResult? _restaurantResult;
  SearchResultState? _state;
  String _message = '';
  String _search = '';

  String get message => _message;

  SearchRestaurantResult? get result => _restaurantResult;

  String get search => _search;

  SearchResultState? get state => _state;

  Future<dynamic> fetchAllRestaurant(String search) async {
    try {
      if (search.isNotEmpty) {
        _state = SearchResultState.loading;
        _search = search;
        notifyListeners();
        final restaurant = await apiService.getTextField(search);
        if (restaurant.restaurants.isEmpty) {
          _state = SearchResultState.noData;
          notifyListeners();
          return _message = 'Data Tidak Ditemukan!';
        } else {
          _state = SearchResultState.hasData;
          notifyListeners();
          return _restaurantResult = restaurant;
        }
      } else {
        return _message = 'text null';
      }
    } on SocketException {
      _state = SearchResultState.error;
      notifyListeners();
      return _message = "non connection";
    } catch (e) {
      _state = SearchResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
