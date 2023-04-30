import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';

class AppTheme {
  static lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.whiteColor,
      //  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      //       .copyWith(secondary: const Color(0xFF2196f3)),
      canvasColor: AppColors.whiteColor,
      brightness: Brightness.light,
      textTheme: GoogleFonts.interTextTheme(AppTheme.textStyle(context)),
    );
  }

  static darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.whiteColor,
      brightness: Brightness.dark,
      textTheme: GoogleFonts.interTextTheme(AppTheme.textStyle(context)),
      // AppTheme.textStyle(context)
    );
  }

  static TextTheme textStyle(BuildContext context) =>
      Theme.of(context).textTheme;
}
