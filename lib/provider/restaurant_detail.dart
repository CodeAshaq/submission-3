import 'dart:async';
import 'dart:io';

import 'package:restaurant_app/data/api/detail_service_api.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:flutter/material.dart';

enum DetailResultState { loading, error, noData, hasData }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiServiceDetail apiService;
  final String id;

  late DetailRestaurantResult _detailRestaurant;
  late DetailResultState _state;
  String _message = '';

  DetailRestaurantProvider({required this.id, required this.apiService}) {
    _fecthDetailRestaurant(id);
  }

  String get message => _message;
  DetailRestaurantResult get result => _detailRestaurant;
  DetailResultState get state => _state;

  Future<dynamic> _fecthDetailRestaurant(String id) async {
    try {
      _state = DetailResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.getDetailId(id);
      if (detailRestaurant.error) {
        _state = DetailResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = DetailResultState.hasData;
        notifyListeners();
        return _detailRestaurant = detailRestaurant;
      }
    } on SocketException {
      _state = DetailResultState.error;
      notifyListeners();
      return _message = "Tidak ada koneksi";
    } catch (e) {
      _state = DetailResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
