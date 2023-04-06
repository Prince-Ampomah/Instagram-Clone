import 'package:flutter/services.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';

class UIPreferenceLayout {
  static void setPreferences() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.whiteColor,
      // statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
  }
}
