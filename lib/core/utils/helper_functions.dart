import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/constants.dart';
import '../widgets/cus_circular_progressbar.dart';

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

onLoading(BuildContext context, String message, {TextStyle? style}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
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
                height: 30,
              ),
              SizedBox(
                height: 25,
                child: Image.asset(Const.loadingGif1),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: style,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      );
    },
  );
}
