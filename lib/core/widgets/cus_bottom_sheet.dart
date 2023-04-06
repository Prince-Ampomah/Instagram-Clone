import 'package:flutter/material.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';

class CustomBottomSheetContainer extends StatelessWidget {
  const CustomBottomSheetContainer({
    super.key,
    required this.child,
    this.height = 0.5,
  });

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * height!,
      width: size.width,
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 5,
            width: 40,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
