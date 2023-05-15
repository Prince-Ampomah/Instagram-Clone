import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/core/widgets/cus_read_more_text.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';
import 'package:instagram_clone/view/profile/edit_profile/edit_profile_view.dart';

import '../../../controller/profile_controller/edit_profile_controller.dart';
import '../../../controller/profile_controller/profile_image_overlay_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_main_button.dart';
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
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '${userModel?.numberOfPost}',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Text('Posts'),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      Text(
                        '${userModel?.numberOfFollowers}',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Text('Followers'),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      Text(
                        '${userModel?.numberOfFollowing}',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Text('Following'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // fullname and bio widget
        GetBuilder<EditProfileController>(
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel?.fullname ?? 'full name',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  if (userModel?.bio != null)
                    CustomReadMore(
                      text: userModel!.bio!,
                      trimLines: 3,
                    )
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        // edit profile, share profile widget
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // edit profile
              AppButton(
                onPressed: () {
                  Get.to(() => EditProfileView(userInfo: userModel));
                },
                buttonHeight: 34,
                title: 'Edit profile',
                fontWeight: FontWeight.bold,
                foregroundColor: Colors.black,
                bgColor: AppColors.buttonBgColor,
                borderRadius: 8,
              ),

              const SizedBox(width: 10),

              // share profile
              AppButton(
                onPressed: () {},
                buttonHeight: 34,
                title: 'Share profile',
                fontWeight: FontWeight.bold,
                foregroundColor: Colors.black,
                bgColor: AppColors.buttonBgColor,
                borderRadius: 8,
              ),

              const Spacer(),

              // icon
              Container(
                width: 50,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 7.5, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.person_add_outlined,
                  size: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

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
