import 'package:flutter/services.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';

class UIPreferenceLayout {
  static void setPreferences(
      {Color statusBarColor = AppColors.whiteColor,
      Brightness statusBarIconBrightness = Brightness.dark,
      Brightness statusBarBrightness = Brightness.dark}) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarBrightness: statusBarBrightness,
        statusBarIconBrightness: statusBarIconBrightness,
      ),
    );

    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: AppColors.blackColor,
    //     statusBarBrightness: Brightness.light,
    //     statusBarIconBrightness: Brightness.light,
    //   ),
    // );
  }
}
