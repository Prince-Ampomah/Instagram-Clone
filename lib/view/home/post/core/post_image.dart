import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/post_controller/like_controller.dart';
import 'package:instagram_clone/controller/post_controller/post_image_controller.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/theme/theme.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';

class PostImage extends StatelessWidget {
  PostImage({
    super.key,
    this.images,
  });

  final List<dynamic>? images;

  /// inject [PostImageController] dependecy
  final postImageController = Get.put(PostImageController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<PostImageController>(
      builder: (controller) {
        return GestureDetector(
          onDoubleTap: () {
            LikeController.instance.likeOnlyOnDoubleTap();
          },
          child: Stack(
            children: [
              SizedBox(
                height: size.height * 0.50,
                width: size.width,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: postImageController.onPageChanged,
                  itemCount: images!.length,
                  itemBuilder: (context, index) {
                    if (images!.length != 1) {
                      return Stack(
                        children: [
                          CustomCachedImge(
                            imageUrl: images![index],
                            width: size.width,
                            shimmerHeight: size.height * 0.70,
                            fit: BoxFit.cover,
                          ),

                          // like button widget
                          GetBuilder<LikeController>(
                            builder: (controller) {
                              if (controller.showLikeIcon) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: AnimatedOpacity(
                                    opacity:
                                        controller.showLikeIcon ? 1.0 : 0.0,
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    child: const Icon(
                                      Icons.favorite,
                                      size: 100,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ],
                      );
                    } else {
                      return Stack(
                        children: [
                          CustomCachedImge(
                            imageUrl: images![index],
                            width: size.width,
                            shimmerHeight: size.height * 0.70,
                            fit: BoxFit.cover,
                          ),

                          // like button widget
                          GetBuilder<LikeController>(
                            builder: (controller) {
                              if (controller.showLikeIcon) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: AnimatedOpacity(
                                    opacity:
                                        controller.showLikeIcon ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 500),
                                    child: const Icon(
                                      Icons.favorite,
                                      size: 100,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          )
                        ],
                      );
                    }
                  },
                ),
              ),

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
                            style: AppTheme.textStyle(context)
                                .titleSmall!
                                .copyWith(
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
      },
    );
  }
}
