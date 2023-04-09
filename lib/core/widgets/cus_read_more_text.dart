import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CustomReadMore extends StatelessWidget {
  const CustomReadMore({
    super.key,
    required this.text,
    this.trimLines = 2,
  });

  final String text;
  final int? trimLines;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: 2,
      trimMode: TrimMode.Line,
      trimCollapsedText: ' more',
      trimExpandedText: ' less',
      moreStyle: const TextStyle(color: Colors.grey),
      lessStyle: const TextStyle(color: Colors.grey),
    );
  }
}
