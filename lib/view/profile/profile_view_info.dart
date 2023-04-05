import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';
import 'package:instagram_clone/view/profile/edit_profile/edit_profile_view.dart';
import '../../controller/profile_controller/edit_profile_controller.dart';
import '../../core/constants/constants.dart';
import '../../core/widgets/cus_rich_text.dart';

class ProfileViewInfo extends StatelessWidget {
  const ProfileViewInfo({
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
          child: CustomRichText(
            text1: '${userInfo.fullname ?? 'full name'}\n',
            text2:
                "A ship is safe in the harbor but that's not ships are for\nWilliam Shed.\nExplore🌍\nAnd\nConquer🙏\nHard work💯",
            text1Style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
            text2Style:
                Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 12),
          ),
        ),

        const SizedBox(height: 20),

        // edit profile, share profile widget
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.put(EditProfileController());
                  Get.to(() => const EditProfileView());
                },
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Edit profile'),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Share profile'),
              ),
              const SizedBox(width: 10),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.person_add_outlined,
                  size: 18,
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
                    height: 65,
                    width: 65,
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
