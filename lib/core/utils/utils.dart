import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme.dart';

class Utils {
  static showErrorMessage(String message, {String title = 'Error'}) {
    Get.snackbar(
      'Error',
      message,
      animationDuration: const Duration(seconds: 3),
      duration: const Duration(seconds: 3),
      backgroundColor: AppColors.errorColor,
      colorText: Colors.white,
      titleText: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
