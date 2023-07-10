import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CircularImageContainer extends StatelessWidget {
  const CircularImageContainer({
    super.key,
    this.height = 0.05,
    this.width = 0.05,
    this.image,
    this.border,
  });

  final double height, width;
  final String? image;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height * height,
      width: size.height * height,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(image ?? Const.userImage),
      ),
    );
  }
}
