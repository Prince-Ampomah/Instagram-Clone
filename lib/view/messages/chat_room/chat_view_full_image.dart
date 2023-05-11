import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';

import '../../../core/widgets/cus_appbar.dart';

class ChatViewFullImage extends StatelessWidget {
  const ChatViewFullImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(
        implyLeading: true,
        bgColor: Colors.black,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: InteractiveViewer(
          maxScale: 5.0,
          child: CustomCachedImage(
            imageUrl: imageUrl,
          ),
        ),
      ),
    );
  }
}
