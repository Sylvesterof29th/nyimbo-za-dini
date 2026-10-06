import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF123B6D);
  static const Color secondaryColor = Color(0xFFD4AF37);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: const Color(0xFFF8F9FB),

    appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),
  );
}
