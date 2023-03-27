import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomCircularProgressBar extends StatelessWidget {
  const CustomCircularProgressBar({
    Key? key,
    this.bgColor = Colors.grey,
    this.valueColor = Colors.white,
  }) : super(key: key);

  final Color? bgColor, valueColor;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: bgColor,
      strokeWidth: 2.0,
      valueColor: AlwaysStoppedAnimation(valueColor),
    );
  }
}

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Image.asset(Const.loadingGif),
    );
  }
}
