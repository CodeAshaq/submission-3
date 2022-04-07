import 'package:flutter/material.dart';

// ignore: prefer_const_declarations
final Color primaryColor = const Color(0xFFFFFFFF);

// ignore: prefer_const_constructors
final Color secondaryColor = Color(0xFFD30000);

enum ResultState { loading, error, noData, hasData }

class Constants {
  static const String textEmptyData = " Empty Data";
  static const String textConnectionError = " Connection Errors";
}
