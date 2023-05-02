import 'package:flutter/foundation.dart';
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

/// light theme
ThemeData customLightTheme(
  BuildContext context,
) {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      platform: defaultTargetPlatform,
      primaryColor: Colors.white,
      primaryIconTheme: const IconThemeData(color: Colors.black),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(37, 112, 252, 1)),
      unselectedWidgetColor: Colors.grey,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.montserrat().fontFamily,
      secondaryHeaderColor: const Color.fromRGBO(37, 112, 252, 1),
      cardColor: const Color.fromRGBO(239, 242, 248, 1),
      iconTheme: const IconThemeData(color: Colors.black),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.black.withOpacity(.5),
      ),
      appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black)),
      textTheme: Typography.material2018(platform: defaultTargetPlatform)
          .white
          .copyWith(
            bodyLarge: const TextStyle(color: Colors.black, fontSize: 16),
            bodyMedium: const TextStyle(color: Colors.black, fontSize: 14),
            bodySmall: const TextStyle(color: Colors.black, fontSize: 12),
            displayLarge: const TextStyle(color: Colors.black, fontSize: 96),
            displayMedium: const TextStyle(color: Colors.black, fontSize: 60),
            displaySmall: const TextStyle(color: Colors.black, fontSize: 48),
            headlineMedium: const TextStyle(color: Colors.black, fontSize: 34),
            headlineSmall: const TextStyle(color: Colors.black, fontSize: 24),
            titleLarge: const TextStyle(color: Colors.black, fontSize: 20),
            titleMedium: const TextStyle(color: Colors.black, fontSize: 16),
            titleSmall: const TextStyle(color: Colors.black, fontSize: 14),
            labelSmall: const TextStyle(color: Colors.black, fontSize: 10),
            labelLarge: const TextStyle(color: Colors.black, fontSize: 16),
          ),
      dividerColor: Colors.grey,
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(37, 112, 252, 1)));
}

///dark theme
ThemeData customDarkTheme(
  BuildContext context,
) {
  return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Colors.black,
      primaryIconTheme: const IconThemeData(color: Colors.grey),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(31, 31, 31, 1)),
      platform: defaultTargetPlatform,
      unselectedWidgetColor: Colors.grey,
      brightness: Brightness.dark,
      secondaryHeaderColor: const Color.fromRGBO(31, 31, 50, 1),
      fontFamily: GoogleFonts.montserrat().fontFamily,
      cardColor: const Color.fromRGBO(31, 31, 31, 1),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.white.withOpacity(.7),
      ),
      appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black)),
      textTheme: Typography.material2018(platform: defaultTargetPlatform)
          .white
          .copyWith(
            bodyLarge: const TextStyle(color: Colors.white, fontSize: 16),
            bodyMedium: const TextStyle(color: Colors.white, fontSize: 14),
            bodySmall: const TextStyle(color: Colors.white, fontSize: 12),
            displayLarge: const TextStyle(color: Colors.white, fontSize: 96),
            displayMedium: const TextStyle(color: Colors.white, fontSize: 60),
            displaySmall: const TextStyle(color: Colors.white, fontSize: 48),
            headlineMedium: const TextStyle(color: Colors.white, fontSize: 34),
            headlineSmall: const TextStyle(color: Colors.white, fontSize: 24),
            titleLarge: const TextStyle(color: Colors.white, fontSize: 20),
            titleMedium: const TextStyle(color: Colors.white, fontSize: 16),
            titleSmall: const TextStyle(color: Colors.white, fontSize: 14),
            labelSmall: const TextStyle(color: Colors.white, fontSize: 10),
            labelLarge: const TextStyle(color: Colors.white, fontSize: 16),
          ),
      iconTheme: const IconThemeData(color: Colors.white),
      dividerColor: Colors.white.withOpacity(.6),
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(105, 73, 199, 1)));
}
