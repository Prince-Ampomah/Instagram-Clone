import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class FeedImage extends StatelessWidget {
  const FeedImage({
    super.key,
    this.images,
    this.image,
  });

  final List<dynamic>? images;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image!);
    // return Flexible(
    //   child: PageView.builder(
    //     itemCount: images.length,
    //     itemBuilder: (context, index) {
    //       return Image.asset(images[index]);
    //     },
    //   ),
    // );
  }
}
