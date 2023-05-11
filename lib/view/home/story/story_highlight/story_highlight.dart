import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/ui_layout_preference.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../../model/story_model/story_model.dart';
import 'story_highlight_media.dart';
import 'story_highlight_user_info.dart';

class StoryHighlightView extends StatefulWidget {
  const StoryHighlightView({
    super.key,
    required this.storyModel,
    this.isCurrentUserStory = false,
  });

  final StoryModel storyModel;
  final bool? isCurrentUserStory;

  @override
  State<StoryHighlightView> createState() => _StoryHighlightViewState();
}

class _StoryHighlightViewState extends State<StoryHighlightView> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

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
        child: PageView(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Stack(
                      children: [
                        StoryMedia(
                          media: widget.storyModel.media!,
                          type: widget.storyModel.storyType!,
                        ),
                        UserInfo(
                          isCurrentUserStory: widget.isCurrentUserStory!,
                          userImage: widget.storyModel.userProfileImage,
                          userHandle: widget.storyModel.userHandle!,
                          timePosted: widget.storyModel.timePosted!,
                        ),
                      ],
                    ),
                  ),
                ),
                const SendMessage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SendMessage extends StatelessWidget {
  const SendMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
    );
  }
}
