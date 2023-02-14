import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme.dart';

class Utils {
  static showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      animationDuration: const Duration(seconds: 3),
      duration: const Duration(seconds: 3),
      backgroundColor: AppColors.errorColor,
      colorText: Colors.white,
      titleText: const Text(
        'Error',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
