import 'package:flutter/material.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';
import 'package:overlay_support/overlay_support.dart';

import '../widgets/cus_dialogs.dart';

class Utils {
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
    Color? textColor = Colors.black,
    NotificationPosition position = NotificationPosition.top,
  }) {
    showSimpleNotification(
      Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
        ),
      ),
      position: position,
      elevation: 0.0,
      background: bgColor,
    );
  }

  static Future<void> customDialog(
    context, {
    String? title,
    text1,
    text2,
    Color? backgroundColor1,
    backgroundColor2,
    textColor1,
    textColor2,
    VoidCallback? onPressed1,
    required VoidCallback onPressed2,
  }) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CusDefaultAlertDialog(
          title: Text(
            title ?? '',
            textAlign: TextAlign.center,
          ),
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          text1: text1,
          text2: text2,
          textColor1: Colors.black,
          textColor2: Colors.red,
          fontWeight1: FontWeight.bold,
          fontWeight2: FontWeight.bold,
          actionsPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 20, 15.0),
          onPressed1: onPressed1 ?? () => Navigator.pop(context),
          onPressed2: onPressed2,
        );
      },
    );
  }
}
