import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CustomReadMore extends StatelessWidget {
  const CustomReadMore({
    super.key,
    required this.text,
    this.textStyle,
    this.moreStyle = const TextStyle(color: Colors.grey),
    this.lessStyle = const TextStyle(color: Colors.grey),
    this.readMoreText = ' more',
    this.readLessText = ' less',
    this.trimLines = 2,
    this.trimeLength = 2,
    this.trimMode = TrimMode.Line,
  });

  final String text;
  final String? readMoreText, readLessText;
  final int? trimLines, trimeLength;
  final TrimMode trimMode;
  final TextStyle? textStyle, moreStyle, lessStyle;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      style: textStyle,
      trimLines: trimLines!,
      trimLength: trimeLength!,
      trimMode: trimMode,
      trimCollapsedText: readMoreText!,
      trimExpandedText: readLessText!,
      moreStyle: moreStyle,
      lessStyle: lessStyle,
    );
  }
}
