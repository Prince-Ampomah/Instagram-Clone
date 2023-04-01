import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder? shapeBorder;

  const ShimmerEffect.rectangular(
      {this.width = double.infinity, required this.height, Key? key})
      : shapeBorder = const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        super(key: key);

  const ShimmerEffect.circular(
      {Key? key,
      this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        period: const Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder!,
          ),
        ),
      );
}
