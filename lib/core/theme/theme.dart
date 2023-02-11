import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.whiteColor,
      brightness: Brightness.light,
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      // Theme.of(context).textTheme
    );
  }

  static darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.whiteColor,
      brightness: Brightness.dark,
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      // Theme.of(context).textTheme
    );
  }

  // static ThemeData lightTheme = ThemeData(
  //   useMaterial3: true,
  //   colorSchemeSeed: AppColors.whiteColor,
  //   brightness: Brightness.light,
  //   // textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
  //   // Theme.of(context).textTheme
  // );
  // static ThemeData darkTheme = ThemeData(
  //   useMaterial3: true,
  //   colorSchemeSeed: AppColors.blackColor,
  //   brightness: Brightness.dark,
  // );
}

class AppColors {
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);
  static const greyColor = Color(0xFF8C8C8C);
  static const buttonColor = Color(0xFF0094F6);
  static const textFieldColor = Color(0xFFF7F7F7);
  static const deepButtonColor = Color(0xFF003050);

  static const storyBorderColors = [
    Color(0xFFfeda75),
    Color(0xFFfa7e1e),
    Color(0xFFd62976),
    Color(0xFF962fbf),
    Color(0xFF4f5bd5),
  ];
}
