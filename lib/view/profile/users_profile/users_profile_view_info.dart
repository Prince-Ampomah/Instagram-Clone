import 'package:flutter/material.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';
import '../../../core/constants/constants.dart';
import '../../../core/theme/app_colors.dart';

class UsersProfileViewInfo extends StatelessWidget {
  const UsersProfileViewInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserModel? userInfo = HiveServices.getUserBox().get(Const.currentUser);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // profile image and (post, follower, following)  widget
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              userInfo!.profileImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CustomCachedImge(
                        height: 75,
                        width: 75,
                        imageUrl: userInfo.profileImage!,
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
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '9',
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
                        '90',
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
                        '100',
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

        // username and caption widget
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userInfo.fullname ?? 'full name',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                '${userInfo.bio}',
                maxLines: 3,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // edit profile, share profile widget
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // follow
              GestureDetector(
                onTap: () {},
                child: Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 40,
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
                ),
              ),

              const SizedBox(width: 10),

              // share profile
              GestureDetector(
                onTap: () {},
                child: Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 40,
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
                ),
              ),

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
