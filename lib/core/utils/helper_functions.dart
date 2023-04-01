import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_clone/core/widgets/cus_circular_progressbar.dart';

import '../constants/constants.dart';
import '../theme/theme.dart';

void showToast({required String msg}) {
  Fluttertoast.showToast(msg: msg);
}

void sendToPage(BuildContext context, Widget newPage,
    {bool fullScreen = false}) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (BuildContext context) => newPage,
        fullscreenDialog: fullScreen),
  );
}

onLoading(BuildContext context, String message, {bool isDimissible = true}) {
  return showDialog(
    context: context,
    barrierDismissible: isDimissible,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
                width: 25,
                child: Center(child: CustomCircularProgressBar()),
              ),
              const SizedBox(width: 15),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTheme.textStyle(context).labelLarge,
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      );
    },
  );
}
