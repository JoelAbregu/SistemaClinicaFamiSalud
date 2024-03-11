import 'package:flutter/material.dart';

class AppTheme {
  static Color colorPrimary = const Color(0xFF0055B2);
  static Color colorSecondary = const Color(0xFF3B7ED5);
  static Color colorTertiary = const Color(0xffEBF4FF);
  static Color colorFourth = const Color(0xffE6B200);
  static Color colorScreen = const Color(0xffF0F0F0);
  static List<Color> colorGradient = [colorSecondary, colorPrimary];

  ThemeData getTheme() {
    return ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
        scaffoldBackgroundColor: colorScreen,
        brightness: Brightness.light,
        colorSchemeSeed: colorPrimary);
  }
}
