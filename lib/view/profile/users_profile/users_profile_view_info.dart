import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/constants.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_read_more_text.dart';
import '../../../model/post_model/post_model.dart';
import '../../../model/user_model/user_model.dart';
import '../../core/follow_button.dart';
import '../../core/unfollow_button.dart';

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
                      child: CustomCachedImage(
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
              // listen to the user model hive box
              ValueListenableBuilder<Box<UserModel>>(
                valueListenable: HiveServices.getUserBox().listenable(),
                builder: (BuildContext context, currentUserBox, _) {
                  bool isInListOFFollowers = currentUserBox
                      .get(Const.currentUser)!
                      .listOfFollowing!
                      .contains(userModel!.userId!);

                  if (isInListOFFollowers) {
                    return UnfollowButton(userToUnfollowId: postModel!.userId!);
                  } else {
                    return FollowButton(userToFollowerId: postModel!.userId!);
                  }
                },
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
