import 'package:flutter/material.dart';

class CustomTheme {
  static Color darkNavy = Color(0xff1C2938);
  static Color lightNavy = Color(0xff9B9BAF);
  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: darkNavy,
      hintColor: lightNavy,
      primaryColor: Colors.greenAccent,
      accentColor: Colors.blue,
      inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.redAccent)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.redAccent))),
    );
  }
}
