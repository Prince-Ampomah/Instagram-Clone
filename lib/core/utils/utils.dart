import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';
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
      background: const Color(0xFFDE4C42),
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

  static Future<void> dialog(
    context, {
    String? title = 'Delete Post?',
    text1 = 'Delete',
    text2 = 'Cancel',
    content,
    Color? backgroundColor1,
    backgroundColor2,
    textColor1,
    textColor2,
    required VoidCallback onTap,
    double height = 0.4,
  }) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: MediaQuery.sizeOf(context).height * height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        if (content != null) 15.ph,
                        if (content != null)
                          Text(
                            content ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Divider(),
                    GestureDetector(
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Text(
                          text1,
                          style: TextStyle(
                            color: textColor1 ?? Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                        child: Text(
                          text2,
                          style: TextStyle(
                            color: textColor1 ?? Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
