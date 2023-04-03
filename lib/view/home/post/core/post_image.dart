import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/post_controller/like_controller.dart';
import 'package:instagram_clone/controller/post_controller/post_image_controller.dart';
import 'package:instagram_clone/core/animation/like_icon_animation.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/theme/theme.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';

import '../../../../core/services/hive_services.dart';

class PostImage extends StatefulWidget {
  const PostImage({
    super.key,
    this.images,
    this.postModel,
  });

  final List<dynamic>? images;
  final PostModel? postModel;

  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> with TickerProviderStateMixin {
  late Animation _heartAnimation;
  late AnimationController _heartAnimationController;

  /// inject [PostImageController] dependecy
  final postImageController = Get.put(PostImageController());

  String? userId = HiveServices.getUserBox().get(Const.currentUser)!.userId;

  Timer? timer;

  bool showLikeIcon = false;

  void likeIconVisibiltyTimer() {
    setState(() {
      showLikeIcon = true;
      _heartAnimationController.forward();
    });

    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        showLikeIcon = false;
        _heartAnimationController.stop();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _heartAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
      reverseDuration: const Duration(milliseconds: 400),
    );
    _heartAnimation = Tween(begin: 90.0, end: 120.0).animate(
      CurvedAnimation(
        curve: Curves.elasticOut,
        reverseCurve: Curves.ease,
        parent: _heartAnimationController,
      ),
    );

    _heartAnimationController.addStatusListener(
      (AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _heartAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _heartAnimationController.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    _heartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<PostImageController>(
      builder: (controller) {
        return GestureDetector(
          onDoubleTap: () async {
            if (widget.postModel!.id != null) {
              await LikeController.instance.likePostOnly(widget.postModel!.id!);
              likeIconVisibiltyTimer();
            }
          },
          child: Stack(
            children: [
              SizedBox(
                height: size.height * 0.50,
                width: size.width,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: postImageController.onPageChanged,
                  itemCount: widget.images!.length,
                  itemBuilder: (context, index) {
                    if (widget.images!.length != 1) {
                      return Stack(
                        children: [
                          CustomCachedImge(
                            imageUrl: widget.images![index],
                            width: size.width,
                            shimmerHeight: size.height * 0.70,
                            fit: BoxFit.cover,
                          ),

                          // like button widget
                          // if (widget.postModel!.isLikedBy!.contains(userId))
                          if (showLikeIcon)
                            const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.favorite,
                                size: 100,
                                color: Colors.white,
                              ),
                            ),

                          // if (widget.postModel!.isLikedBy!.contains(userId))
                          //   GetBuilder<LikeController>(
                          //     builder: (controller) {
                          //       if (controller.showLikeIcon) {
                          //         return Align(
                          //           alignment: Alignment.center,
                          //           child: AnimatedOpacity(
                          //             opacity:
                          //                 controller.showLikeIcon ? 1.0 : 0.0,
                          //             duration:
                          //                 const Duration(milliseconds: 1000),
                          //             child: const Icon(
                          //               Icons.favorite,
                          //               size: 100,
                          //               color: Colors.red,
                          //             ),
                          //           ),
                          //         );
                          //       } else {
                          //         return const SizedBox();
                          //       }
                          //     },
                          //   ),
                        ],
                      );
                    } else {
                      return Stack(
                        children: [
                          CustomCachedImge(
                            imageUrl: widget.images![index],
                            width: size.width,
                            shimmerHeight: size.height * 0.70,
                            fit: BoxFit.cover,
                          ),

                          // like button widget

                          if (widget.postModel!.isLikedBy!.contains(userId) &&
                              showLikeIcon)
                            AnimatedBuilder(
                              animation: _heartAnimationController,
                              builder: (context, child) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.favorite,
                                    size: _heartAnimation.value,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: AnimatedOpacity(
                          //     opacity: showLikeIcon ? 1.0 : 0.3,
                          //     duration: const Duration(milliseconds: 500),
                          //     child: const Icon(
                          //       Icons.favorite,
                          //       size: 100,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),

                          // if (widget.postModel!.isLikedBy!.contains(userId))
                          //   GetBuilder<LikeController>(
                          //     builder: (controller) {
                          //       if (controller.showLikeIcon) {
                          //         return Align(
                          //           alignment: Alignment.center,
                          //           child: AnimatedOpacity(
                          //             opacity:
                          //                 controller.showLikeIcon ? 1.0 : 0.0,
                          //             duration:
                          //                 const Duration(milliseconds: 500),
                          //             child: const Icon(
                          //               Icons.favorite,
                          //               size: 100,
                          //               color: Colors.red,
                          //             ),
                          //           ),
                          //         );
                          //       } else {
                          //         return const SizedBox();
                          //       }
                          //     },
                          //   ),
                        ],
                      );
                    }
                  },
                ),
              ),

              // image counter widget
              widget.images!.length != 1
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
                            '${postImageController.countImage}/${widget.images!.length}',
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
