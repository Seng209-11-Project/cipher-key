import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: Colors.white,
      primary: Colors.black,
      secondary: Colors.grey,
    ),
  );

  static ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
          surface: Colors.black,
          primary: Colors.white,
          secondary: Colors.grey
      )
  );
}