import 'package:flutter/material.dart';

class CameraCloseButton extends StatelessWidget {
  const CameraCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.06,
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
