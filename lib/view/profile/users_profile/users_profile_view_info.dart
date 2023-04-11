import 'package:flutter/material.dart';

import '../../../controller/follow_controller/follow_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_read_more_text.dart';
import '../../../model/post_model/post_model.dart';
import '../../../model/user_model/user_model.dart';

class UsersProfileViewInfo extends StatelessWidget {
  const UsersProfileViewInfo({
    super.key,
    this.userModel,
    this.postModel,
  });

  final UserModel? userModel;
  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    UserModel? currentUser = HiveServices.getUserBox().get(Const.currentUser);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // profile image and (post, follower, following)  widget
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              userModel!.profileImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CustomCachedImge(
                        height: 75,
                        width: 75,
                        imageUrl: userModel!.profileImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
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
                        '${userModel!.numberOfPost}',
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
                        '${userModel!.numberOfFollowers}',
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
                        '${userModel!.numberOfFollowing}',
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
        Padding(
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
              if (userModel!.bio != null)
                CustomReadMore(
                  text: userModel!.bio!,
                  trimLines: 3,
                )
            ],
          ),
        ),

        const SizedBox(height: 20),

        // follow and message widget
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              // follow button
              userModel!.listOfFollowers!.contains(currentUser!.userId)
                  ? UnfollowButton(
                      postModel: postModel,
                      userModel: userModel,
                    )
                  : FollowButton(
                      postModel: postModel,
                      userModel: userModel,
                    ),

              const SizedBox(width: 10),

              // message button
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Message',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // const SizedBox(width: 10),
              const Spacer(),

              // icon
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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

class FollowButton extends StatelessWidget {
  const FollowButton({
    super.key,
    required this.postModel,
    required this.userModel,
  });

  final PostModel? postModel;
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FollowController.instance.followUser(postModel!.userId!);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Follow',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}

class UnfollowButton extends StatelessWidget {
  const UnfollowButton({
    super.key,
    required this.postModel,
    required this.userModel,
  });

  final PostModel? postModel;
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FollowController.instance.unFollowUser(postModel!.userId!);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Unfollow',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
