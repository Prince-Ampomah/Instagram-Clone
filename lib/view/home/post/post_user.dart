import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/view/layout/app_layout.dart';
import 'package:instagram_clone/view/profile/users_profile/users_profile_view.dart';

import '../../../core/constants/constants.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/widgets/cus_circular_image.dart';
import '../../../model/user_model/user_model.dart';

class PostUser extends StatelessWidget {
  const PostUser({
    super.key,
    this.userModel,
    this.postModel,
  });

  final UserModel? userModel;
  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // compare the user id in post model and the current user id
        if (postModel!.userId !=
            HiveServices.getUserBox().get(Const.currentUser)!.userId) {
          Get.to(
            () => UsersProfileView(
              userModel: userModel,
              postModel: postModel,
            ),
          );
        } else {
          Get.to(() => AppLayoutView(pageIndex: 4));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Row(
              children: [
                userModel!.profileImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CustomCachedImge(
                          height: 40,
                          width: 40,
                          imageUrl: userModel!.profileImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const CircularImageContainer(image: Const.userImage),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          // userHandle ?? 'instagram handle',
                          userModel!.userHandle ?? 'instagram handle',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(
                          Const.instragramVerifiedIcon,
                          height: 15,
                          width: 15,
                        ),
                        // Container(
                        //   height: 15,
                        //   width: 15,
                        //   decoration: const BoxDecoration(
                        //       color: Colors.blue, shape: BoxShape.circle),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(20),
                        //     child: const Icon(
                        //       Icons.check,
                        //       color: Colors.white,
                        //       size: 10,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    const Text('location'),
                  ],
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                showToast(msg: 'dd');
              },
              child: const Icon(Icons.more_vert),
            )
          ],
        ),
      ),
    );
  }
}
