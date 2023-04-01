import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarouselSliderBuilder extends StatelessWidget {
  const CustomCarouselSliderBuilder({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.autoplay = false,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.viewportFraction = 0.8,
    this.height,
    this.scrollPhysics,
    this.onPageChanged,
  }) : super(key: key);

  final int? itemCount;
  final bool autoplay;
  final Duration autoPlayInterval;
  final double viewportFraction;
  final double? height;
  final Widget Function(BuildContext, int, int)? itemBuilder;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final ScrollPhysics? scrollPhysics;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      options: CarouselOptions(
          height: height,
          autoPlay: autoplay,
          autoPlayInterval: autoPlayInterval,
          scrollPhysics: scrollPhysics,
          viewportFraction: viewportFraction,
          onPageChanged: onPageChanged),
    );
  }
}

class CustomImageSlider extends StatelessWidget {
  const CustomImageSlider(
      {Key? key,
      required this.items,
      this.autoplay = true,
      this.viewportFraction = 1.0,
      this.aspectRatio = 16 / 9})
      : super(key: key);

  final List<Widget> items;
  final bool? autoplay;

  final double? viewportFraction;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: autoplay!,
        aspectRatio: aspectRatio,
        enlargeCenterPage: true,
        viewportFraction: viewportFraction!,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        autoPlayCurve: Curves.ease,
      ),
      items: items,
    );
  }
}
