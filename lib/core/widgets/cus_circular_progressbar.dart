import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/theme.dart';
import 'dart:math' as math;

class CustomCircularProgressBar extends StatelessWidget {
  const CustomCircularProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(AppColors.blackColor),
    );
  }
}

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: SizedBox(
        height: 50,
        child: Image.asset(Const.loadingGif),
      ),
    );
  }
}
