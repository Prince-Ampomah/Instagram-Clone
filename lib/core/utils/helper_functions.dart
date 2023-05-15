import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/theme.dart';
import '../widgets/cus_circular_progressbar.dart';

void showToast({
  required String msg,
  ToastGravity? gravity,
  Color? bgColor,
  Color? textColor,
}) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: gravity,
    backgroundColor: bgColor,
    textColor: textColor,
  );
}

Future<dynamic> showFlushBar(
  BuildContext context, {
  required String message,
  String? title,
  Color? bgColor = const Color(0xFF303030),
  titleColor,
  messageColor,
}) async {
  await Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    title: title,
    message: message,
    titleColor: titleColor,
    messageColor: messageColor,
    duration: const Duration(seconds: 3),
    backgroundColor: bgColor!,
  ).show(context);
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

void noReturnPushReplacement(
  BuildContext context,
  Widget newPage,
) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => newPage,
      ));
}

void popUntil(BuildContext context, int numberOfScreen) {
  int count = 0;
  Navigator.of(context).popUntil((_) => count++ >= numberOfScreen);
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

Future<String> getImagePicker(imageSource) async {
  ImagePicker imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(source: imageSource);
  String image = '';
  if (pickedFile != null) {
    image = pickedFile.path;
  }
  return image;
}

Future<void> makePhoneCall(String phoneNumber) async {
  try {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  } catch (e) {
    Utils.showErrorMessage(e.toString());
  }
}
