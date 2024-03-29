import 'package:flutter/material.dart';

class CameraCloseButton extends StatelessWidget {
  const CameraCloseButton({
    super.key,
    this.height = 0.06,
  });

  final double? height;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * height!,
        right: 10,
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
