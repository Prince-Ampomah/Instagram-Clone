import 'package:flutter/material.dart';
import 'package:instagram_clone/view/home/post/post_current_user_bottomsheet_activity.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../model/post_model/post_model.dart';
import 'post_user_bottomsheet_activity.dart';
import '../../layout/app_layout.dart';
import '../../profile/users_profile/users_profile_view.dart';

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
    String? currentUserId =
        HiveServices.getUserBox().get(Const.currentUser)?.userId!;
    return InkWell(
      onTap: () {
        // compare the user id in post model and the current user id
        if (postModel!.userId != currentUserId) {
          sendToPage(
            context,
            UsersProfileView(
              userModel: userModel,
              postModel: postModel,
            ),
          );
        } else {
          sendToPage(context, const AppLayoutView(pageIndex: 4));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Row(
              children: [
                if (userModel!.profileImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CustomCachedImage(
                      height: 40,
                      width: 40,
                      imageUrl: userModel!.profileImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  const CircularImageContainer(image: Const.userImage),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
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
                      ],
                    ),
                    // const Text('location'),
                  ],
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // show the type of bottom sheet
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      if (postModel!.userId != currentUserId) {
                        return PostUserBottomSheetActivity(
                          postModel: postModel,
                          userModel: userModel,
                        );
                      } else {
                        return PostCurrentUserBottomSheetActivity(
                          postModel: postModel,
                          userModel: userModel,
                        );
                      }
                    });
              },
              child: const Icon(Icons.more_vert),
            )
          ],
        ),
      ),
    );
  }
}
