import 'package:flutter/material.dart';
import 'package:instagram_clone/controller/models_controller/models_controller.dart';
import 'package:instagram_clone/controller/profile_controller/profile_image_overlay_controller.dart';

import '../../../core/constants/constants.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../model/post_model/post_model.dart';
import '../../../model/user_model/user_model.dart';
import '../core//users/follow_message_and_contact.dart';
import '../core//users/num_of_post_followers_and_following.dart';
import '../core/users/fullname_and_bio.dart';
import '../core/users/story_highligt.dart';
import '../profile_image_overlay.dart';

class UsersProfileViewInfo extends StatefulWidget {
  const UsersProfileViewInfo({
    super.key,
    this.userModel,
    this.postModel,
  });

  final UserModel? userModel;
  final PostModel? postModel;

  @override
  State<UsersProfileViewInfo> createState() => _UsersProfileViewInfoState();
}

class _UsersProfileViewInfoState extends State<UsersProfileViewInfo> {
  ProfileImageOverlayController overlayController =
      ProfileImageOverlayController();

  @override
  void initState() {
    super.initState();
    ModelController.instance.postModel = widget.postModel!;
  }

  @override
  void dispose() {
    overlayController.removeProfilePicOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // profile image and (post, follower, following)  widget
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.userModel!.profileImage != null)
                GestureDetector(
                  onTap: () {
                    overlayController.createProfilePicOverlay(
                      context,
                      ProfileImageOverlay(
                        onTap: overlayController.removeProfilePicOverlay,
                        imageUrl: widget.userModel!.profileImage!,
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CustomCachedImage(
                      height: 75,
                      width: 75,
                      imageUrl: widget.userModel!.profileImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  height: 65,
                  width: 65,
                  margin: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Image.asset(
                      Const.userImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              // number of post, followers and following
              PostFollowerAndFollowing(userModel: widget.userModel!),
            ],
          ),
        ),

        // fullname and bio widget
        FullnameAndBio(userModel: widget.userModel),

        const SizedBox(height: 20),

        // follow and message widget
        FollowMessageAndContact(
          userModel: widget.userModel!,
          postModel: widget.postModel!,
        ),

        const SizedBox(height: 20),

        // stories widget
        const StoryHighlight(),
      ],
    );
  }
}
