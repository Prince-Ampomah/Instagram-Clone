import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    Key? key,
    this.text1,
    this.text2,
    this.text1Style = const TextStyle(color: Colors.black),
    this.text2Style = const TextStyle(color: Colors.black),
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  final String? text1;
  final String? text2;
  final TextStyle? text1Style;
  final TextStyle? text2Style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: text1Style,
          ),
          TextSpan(
            text: text2,
            style: text2Style,
          ),
        ],
      ),
    );
  }
}
