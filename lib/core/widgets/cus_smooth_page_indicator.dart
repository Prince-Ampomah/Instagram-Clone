import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothIndicator extends StatelessWidget {
  const CustomSmoothIndicator({
    Key? key,
    required this.activeIndex,
    required this.count,
    this.activeDotColor = Colors.indigo,
    this.dotColor = Colors.grey,
  }) : super(key: key);

  final int activeIndex;
  final int count;
  final Color? dotColor, activeDotColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
      effect: WormEffect(
        dotHeight: 10.0,
        dotWidth: 10.0,
        radius: 10.0,
        type: WormType.thin,
        activeDotColor: activeDotColor!,
        dotColor: dotColor!,
      ),
    );
  }
}
