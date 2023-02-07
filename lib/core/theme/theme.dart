import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.whiteColor,
    brightness: Brightness.light,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.blackColor,
    brightness: Brightness.dark,
  );
}

class AppColors {
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);
}
