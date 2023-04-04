import 'package:flutter/material.dart';

class CusBottomSheetIcons extends StatelessWidget {
  const CusBottomSheetIcons({
    Key? key,
    required this.icons,
    required this.text,
    required this.onTap,
    this.color,
    this.height = 53,
    this.width = 53,
    this.iconSize = 30,
    this.circleWidth = 0.2,
    this.textSize = 14.0,
  }) : super(key: key);

  final IconData icons;
  final Color? color;
  final String text;
  final double? height, width, textSize;
  final double circleWidth, iconSize;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: height,
            width: width,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: const Color(0xFF3D3D3D), width: circleWidth),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(50),
              child: Icon(
                icons,
                size: iconSize,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            text,
            style: TextStyle(fontSize: textSize),
          )
        ],
      ),
    );
  }
}
