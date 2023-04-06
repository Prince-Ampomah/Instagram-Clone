import 'package:flutter/material.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';
import 'package:overlay_support/overlay_support.dart';

class Utils {
  // static showErrorMessage(String message, {String title = 'Error'}) {
  //   Get.snackbar(
  //     'Error',
  //     message,
  //     animationDuration: const Duration(seconds: 3),
  //     duration: const Duration(seconds: 3),
  //     backgroundColor: AppColors.errorColor,
  //     colorText: Colors.white,
  //     titleText: Text(
  //       title,
  //       textAlign: TextAlign.center,
  //       style: const TextStyle(color: Colors.white),
  //     ),
  //     messageText: Text(
  //       message,
  //       textAlign: TextAlign.center,
  //       style: const TextStyle(color: Colors.white),
  //     ),
  //   );
  // }

  static showErrorMessage(String message) {
    showSimpleNotification(
      Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      elevation: 0.0,
      background: AppColors.errorColor,
    );
  }

  static showSuccessMessage(String message) {
    showSimpleNotification(
      Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
      ),
      elevation: 0.0,
      background: AppColors.successColor, //const Color(0xFFCECECE),
    );
  }
}
