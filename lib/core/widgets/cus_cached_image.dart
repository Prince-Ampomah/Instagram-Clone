import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus.shimmer.effect.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    Key? key,
    required this.imageUrl,
    this.fit,
    this.height,
    this.width,
    this.alignment,
    this.containerColor,
    this.placeholderWidget,
    this.errorWidget,
    this.shape = BoxShape.circle,
    this.shimmerHeight = 100,
  }) : super(key: key);
  final String imageUrl;
  final BoxFit? fit;
  final double? height, width, shimmerHeight;
  final Widget? placeholderWidget, errorWidget;
  final Color? containerColor;
  final Alignment? alignment;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    bool isValidURL = Uri.parse(imageUrl).isAbsolute;
    return isValidURL
        ? CachedNetworkImage(
            height: height,
            width: width,
            fit: fit,
            imageUrl: imageUrl,
            placeholder: (context, url) => Center(
              child: Container(
                alignment: alignment,
                decoration: BoxDecoration(
                  shape: shape!,
                  color: containerColor,
                ),
                child: placeholderWidget ??
                    ShimmerEffect.rectangular(height: shimmerHeight),
              ),
            ),
            errorWidget: (context, url, error) => _buildErrorWidget(),
          )
        : File(imageUrl).existsSync()
            ? Image.file(
                File(imageUrl),
                height: height,
                width: width,
                fit: fit,
              )
            : _buildErrorWidget();
  }

  Center _buildErrorWidget() {
    return Center(
        child: Container(
      alignment: alignment,
      decoration: BoxDecoration(
        shape: shape!,
        color: containerColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: errorWidget ?? const Text('Error Loading Image'),
      ),
    ));
  }
}
