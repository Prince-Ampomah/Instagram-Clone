import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';

import '../../../controller/models_controller/models_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_circular_image.dart';
import '../../../core/widgets/cus_primary_button.dart';
import '../../../model/user_model/user_model.dart';
import '../users_profile/users_profile_view.dart';

class ListFollowingItem extends StatelessWidget {
  const ListFollowingItem({super.key, required this.followingUsers});

  final List<UserModel> followingUsers;

  @override
  Widget build(BuildContext context) {
    if (followingUsers.isNotEmpty) {
      return ListView.builder(
        itemCount: followingUsers.length,
        itemBuilder: (BuildContext context, int index) {
          UserModel userModel = followingUsers[index];
          return GestureDetector(
            onTap: () {
              sendToPage(
                context,
                UsersProfileView(
                  userModel: userModel,
                  postModel: ModelController.instance.postModel,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Row(
                children: [
                  if (userModel.profileImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CustomCachedImage(
                        height: 55,
                        width: 55,
                        imageUrl: userModel.profileImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const CircularImageContainer(image: Const.userImage),
                  20.pw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel.userHandle!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        3.ph,
                        Text(userModel.fullname!),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PrimaryButton(
                      onPressed: () {},
                      title: 'Following',
                      buttonHeight: 32,
                      foregroundColor: Colors.black,
                      bgColor: AppColors.buttonBgColor,
                      borderRadius: 8,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return const Center(child: Text('You do not follow anyone'));
    }
  }
}
