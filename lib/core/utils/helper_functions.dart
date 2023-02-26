import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              SizedBox(
                height: 25,
                child: Image.asset(Const.loadingGif1),
              ),
              const SizedBox(width: 10),
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
