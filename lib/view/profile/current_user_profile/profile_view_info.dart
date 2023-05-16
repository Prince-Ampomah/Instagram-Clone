import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';

import '../../../controller/profile_controller/edit_profile_controller.dart';
import '../../../controller/profile_controller/profile_image_overlay_controller.dart';
import '../../../core/constants/constants.dart';
import '../core/current_user/current_user_edit_and_share_profile.dart';
import '../core/current_user/current_user_fullname_and_bio.dart';
import '../core/current_user/current_user_post_follower_and_following.dart';
import '../profile_image_overlay.dart';

class ProfileViewInfo extends StatefulWidget {
  const ProfileViewInfo({
    super.key,
  });

  @override
  State<ProfileViewInfo> createState() => _ProfileViewInfoState();
}

class _ProfileViewInfoState extends State<ProfileViewInfo> {
  late UserModel? userModel;

  ProfileImageOverlayController overlayController =
      ProfileImageOverlayController();

  @override
  void dispose() {
    overlayController.removeProfilePicOverlay();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userModel = HiveServices.getUserBox().get(Const.currentUser);
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
              if (userModel!.profileImage != null)
                GetBuilder<EditProfileController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        overlayController.createProfilePicOverlay(
                          context,
                          ProfileImageOverlay(
                            onTap: overlayController.removeProfilePicOverlay,
                            imageUrl: userModel!.profileImage!,
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CustomCachedImage(
                          height: 75,
                          width: 75,
                          imageUrl: userModel!.profileImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
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
              CurrentUserPostFollowersFollowing(userModel: userModel),
            ],
          ),
        ),

        // fullname and bio widget
        CurrentUserFullnameAndBio(userModel: userModel),

        const SizedBox(height: 20),

        // edit profile, share profile widget
        CurrentUserEditAndShareProfile(userModel: userModel),

        const SizedBox(height: 20),

        // stories widget
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                3,
                (index) {
                  return Container(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all()),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(Const.userImage),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
