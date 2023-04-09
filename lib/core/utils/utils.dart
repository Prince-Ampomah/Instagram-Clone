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
      background: const Color(0xFFDD3529),
    );
  }

  static showNotificationMessage(
    String message, {
    Color? bgColor = AppColors.successColor,
    NotificationPosition position = NotificationPosition.top,
  }) {
    showSimpleNotification(
      Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
      ),
      position: position,
      elevation: 0.0,
      background: bgColor,
    );
  }
}
