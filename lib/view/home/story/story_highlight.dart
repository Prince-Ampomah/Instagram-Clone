import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/utils/date_time_convertor.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/core/widgets/cus_circular_image.dart';
import 'package:instagram_clone/model/story_model/story_model.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/ui_layout_preference.dart';
import '../../../core/widgets/cus_bottom_sheet.dart';
import '../../../core/widgets/cus_list_tile.dart';

class StoryHighlightView extends StatelessWidget {
  const StoryHighlightView({
    super.key,
    required this.storyModel,
    this.isCurrentUserStory = false,
  });

  final StoryModel storyModel;
  final bool? isCurrentUserStory;

  @override
  Widget build(BuildContext context) {
    UIPreferenceLayout.setPreferences(
      statusBarColor: AppColors.blackColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Stack(
                  children: [
                    StoryMedia(media: storyModel.media!),

                    UserInfo(
                      isCurrentUserStory: isCurrentUserStory!,
                      userImage: storyModel.userProfileImage,
                      userHandle: storyModel.userHandle!,
                      timePosted: storyModel.timePosted!,
                    ),
                    // Align(
                    //   alignment: Alignment.topCenter,
                    //   child: Padding(
                    //     padding: EdgeInsets.all(20),
                    //     child: LinearProgressIndicator(
                    //       value: 0.5,
                    //       minHeight: 2,
                    //       backgroundColor: Colors.red,
                    //       valueColor: AlwaysStoppedAnimation(Colors.white),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

            // send message
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: .5, color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: const [
                        Flexible(
                          child: TextField(
                            maxLines: 7,
                            minLines: 1,
                            style: TextStyle(color: Colors.white),
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.newline,
                            textAlign: TextAlign.justify,
                            cursorColor: AppColors.whiteColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              border: InputBorder.none,
                              hintText: 'Send message',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 15, 8),
                          child: Text(
                            'Send',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showToast(msg: '❤️');
                  },
                  child: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                    size: 27,
                  ),
                ),
                15.pw,
                GestureDetector(
                  onTap: () {
                    showToast(msg: '📩');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SizedBox(
                      height: 22,
                      child: Image.asset(
                        Const.instragramSendIcon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StoryMedia extends StatefulWidget {
  const StoryMedia({
    super.key,
    required this.media,
  });

  final List media;

  @override
  State<StoryMedia> createState() => _StoryMediaState();
}

class _StoryMediaState extends State<StoryMedia> {
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: GestureDetector(
        onTapDown: (details) {},
        child: PageView.builder(
          controller: pageController,
          itemCount: widget.media.length,
          itemBuilder: (context, index) {
            return CustomCachedImage(
              imageUrl: widget.media[index],
              fit: BoxFit.cover,
              width: size.width,
              height: size.height,
            );
          },
        ),
      ),
    );
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({
    super.key,
    required this.isCurrentUserStory,
    this.userImage,
    required this.userHandle,
    required this.timePosted,
  });

  final bool isCurrentUserStory;
  final String? userImage;
  final String userHandle;
  final DateTime timePosted;

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  double percent = 0.0;

  Timer? timer;

  startStoryHighlightTimer() {
    timer = Timer.periodic(
      const Duration(milliseconds: 20),
      (timer) {
        setState(() {
          percent += 0.004;
          if (percent > 1) {
            timer.cancel();
            Navigator.pop(context);
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startStoryHighlightTimer();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 2,
              backgroundColor: Colors.white54,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    widget.userImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CustomCachedImage(
                              imageUrl: widget.userImage!,
                              fit: BoxFit.cover,
                              height: 35,
                              width: 35,
                            ),
                          )
                        : CircularImageContainer(
                            border: Border.all(
                              width: 1.0,
                              color: Colors.white,
                            ),
                          ),
                    10.pw,
                    Text(
                      widget.userHandle,
                      style: const TextStyle(color: Colors.white),
                    ),
                    10.pw,
                    Text(
                      DateTimeConvertor.getTimeAgo(widget.timePosted),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (!widget.isCurrentUserStory)
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return CustomBottomSheetContainer(
                          height: 0.27,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomListTile(
                                onTap: () {},
                                minLeadingWidth: 20,
                                leading: SizedBox(
                                  height: 22,
                                  child: Image.asset(
                                    Const.instragramSendIcon,
                                    color: Colors.black,
                                  ),
                                ),
                                title: "We're moving things around",
                                subTitle: 'See where to share and link',
                                titleStyle: const TextStyle(fontSize: 15),
                                subTitleStyle: const TextStyle(
                                  color: AppColors.buttonColor,
                                  fontSize: 15,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                              const Divider(),
                              // CustomListTile(
                              //   onTap: () {},
                              //   title: "Report...",
                              //   titleStyle: const TextStyle(
                              //     color: Colors.red,
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                              // CustomListTile(
                              //   onTap: () {},
                              //   title: "Mute",
                              //   titleStyle: const TextStyle(
                              //     color: Colors.black,
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Report...',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    25.ph,
                                    const Text(
                                      'Mute',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
