import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CustomReadMore extends StatelessWidget {
  const CustomReadMore({
    super.key,
    required this.text,
    this.trimLines = 2,
    this.textStyle,
    this.moreStyle = const TextStyle(color: Colors.grey),
    this.lessStyle = const TextStyle(color: Colors.grey),
    this.readMoreText = ' more',
    this.readLessText = ' less',
  });

  final String text;
  final String? readMoreText, readLessText;
  final int? trimLines;
  final TextStyle? textStyle, moreStyle, lessStyle;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      style: textStyle,
      trimLines: 2,
      trimMode: TrimMode.Line,
      trimCollapsedText: readMoreText!,
      trimExpandedText: readLessText!,
      moreStyle: moreStyle,
      lessStyle: lessStyle,
    );
  }
}
