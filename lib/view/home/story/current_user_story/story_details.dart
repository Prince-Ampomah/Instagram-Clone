import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/core/widgets/cus_circular_image.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/ui_layout_preference.dart';

class StoryDetailsView extends StatelessWidget {
  const StoryDetailsView({super.key});

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
                  children: const [
                    StoryInfo(),
                    UserInfo(),
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

class StoryInfo extends StatelessWidget {
  const StoryInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: CustomCachedImage(
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/instagram-clone-b31aa.appspot.com/o/posts%2FRY1RrATjteJMLE45KuGh%2FIMG_20230501_094902.jpg?alt=media&token=8ad678c4-c40b-437b-b634-9f70e943edd4',
        fit: BoxFit.cover,
        width: size.width,
        height: size.height,
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Row(
            children: [
              CircularImageContainer(
                border: Border.all(
                  width: 1.0,
                  color: Colors.white,
                ),
              ),
              const Text(
                'pompiido_',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              10.pw,
              const Text(
                '15',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
