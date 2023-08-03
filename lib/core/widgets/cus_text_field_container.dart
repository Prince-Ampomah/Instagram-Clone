import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    Key? key,
    this.child,
    this.color = const Color(0xFFD4D4D4),
    this.borderRadius = 10,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 5.0,
      vertical: 2.0,
    ),
    this.margin = const EdgeInsets.only(right: 5),
  }) : super(key: key);

  final Widget? child;
  final Color? color;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: margin,
      padding: padding,
      width: size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
      child: child,
    );
  }
}
