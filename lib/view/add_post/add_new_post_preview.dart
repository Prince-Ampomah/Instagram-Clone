import 'package:flutter/material.dart';

import '../../controller/post_controller/new_post_controller.dart';
import '../../core/widgets/cus_appbar.dart';
import '../../core/widgets/cus_cached_image.dart';

class NewPostPreview extends StatelessWidget {
  const NewPostPreview({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        leadingIcon: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.clear, size: 30),
        ),
        title: 'Preview',
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: PageView.builder(
          itemCount: NewPostController.instance.media.length,
          itemBuilder: (context, index) {
            if (NewPostController.instance.media.length != 1) {
              return CustomCachedImage(
                imageUrl: NewPostController.instance.media[index]!,
              );
            } else {
              return CustomCachedImage(
                imageUrl: NewPostController.instance.media[index]!,
              );
            }
          },
        ),
      ),
    );
  }
}
