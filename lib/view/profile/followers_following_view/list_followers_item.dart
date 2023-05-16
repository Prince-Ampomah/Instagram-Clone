import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/view/profile/users_profile/users_profile_view.dart';

import '../../../controller/models_controller/models_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_circular_image.dart';
import '../../../core/widgets/cus_main_button.dart';
import '../../../model/user_model/user_model.dart';

class ListFollowerItem extends StatelessWidget {
  const ListFollowerItem({super.key, required this.followersUsers});

  final List<UserModel> followersUsers;

  @override
  Widget build(BuildContext context) {
    if (followersUsers.isNotEmpty) {
      return ListView.builder(
        itemCount: followersUsers.length,
        itemBuilder: (BuildContext context, int index) {
          UserModel userModel = followersUsers[index];

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
                      title: 'Remove',
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
      return const Center(child: Text('No Followers'));
    }
  }
}
