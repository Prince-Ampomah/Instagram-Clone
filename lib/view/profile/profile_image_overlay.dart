import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/widgets/cus_cached_image.dart';

class ProfileImageOverlay extends StatelessWidget {
  const ProfileImageOverlay({
    super.key,
    this.onTap,
    required this.imageUrl,
  });

  final Function()? onTap;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
          tileMode: TileMode.mirror,
        ),
        child: Align(
          alignment: Alignment.center,
          heightFactor: 1.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CustomCachedImage(
              height: 200,
              width: 200,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
