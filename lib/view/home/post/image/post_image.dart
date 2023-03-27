import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/post_controller/post_image_controller.dart';
import 'package:instagram_clone/core/theme/theme.dart';

class PostImage extends StatelessWidget {
  PostImage({
    super.key,
    this.images,
    this.image,
  });

  final List<dynamic>? images;
  final String? image;

  /// inject [PostImageController] dependecy
  final postImageController = Get.put(PostImageController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<PostImageController>(
      builder: (controller) => Stack(
        children: [
          images!.length != 1
              ? SizedBox(
                  height: size.height * 0.50,
                  width: size.width,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    onPageChanged: postImageController.onPageChanged,
                    itemCount: images!.length,
                    itemBuilder: (context, index) {
                      String img = images![index];

                      return Stack(
                        children: [
                          Image.asset(img),
                          const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.favorite,
                              size: 100,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              : Image.asset(images!.first),

          // image counter widget
          images!.length != 1
              ? Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: size.height * 0.05,
                    width: size.width * 0.10,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${postImageController.countImage}/${images!.length}',
                        style: AppTheme.textStyle(context).titleSmall!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
