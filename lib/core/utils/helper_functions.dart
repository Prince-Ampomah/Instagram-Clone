import 'package:flutter/material.dart';

void sendToPage(BuildContext context, Widget newPage,
    {bool fullScreen = false}) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (BuildContext context) => newPage,
        fullscreenDialog: fullScreen),
  );
}
