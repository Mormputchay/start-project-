import 'package:flutter/material.dart';

class MyTheme {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(color: Colors.white),
        headlineLarge: TextStyle(color: Colors.black),
        displayMedium: TextStyle(color: Colors.white),
        displaySmall: TextStyle(color: Colors.green),
      ));
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(color: Colors.black),
        headlineLarge: TextStyle(color: Colors.black),
        displayMedium: TextStyle(color: Colors.black),
        displaySmall: TextStyle(color: Colors.green),
      ));
}
