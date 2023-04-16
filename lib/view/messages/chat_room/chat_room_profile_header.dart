import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';

import '../../../controller/models_controller/models_controller.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_circular_image.dart';
import '../../../core/widgets/cus_main_button.dart';
import '../../../model/user_model/user_model.dart';
import '../../profile/users_profile/users_profile_view.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          10.ph,
          userModel.profileImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomCachedImage(
                    height: 80,
                    width: 80,
                    imageUrl: userModel.profileImage!,
                    fit: BoxFit.cover,
                  ),
                )
              : CircularImageContainer(
                  height: 0.07,
                  width: 0.07,
                  border: Border.all(width: 1.0),
                ),
          10.ph,
          Text(
            userModel.fullname!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          5.ph,

          // user handle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userModel.userHandle!,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              Container(
                height: 2,
                width: 2,
                margin: const EdgeInsets.only(left: 3, right: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 107, 107, 107),
                ),
              ),
              const Text(
                'Instagram',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          5.ph,

          // number of followers and post
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userModel.numberOfFollowers > 1
                    ? '${userModel.numberOfFollowers} followers'
                    : '${userModel.numberOfFollowers} follower',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 2,
                width: 2,
                margin: const EdgeInsets.only(left: 3, right: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 107, 107, 107),
                ),
              ),
              Text(
                userModel.numberOfPost > 1
                    ? '${userModel.numberOfPost} posts'
                    : '${userModel.numberOfPost} post',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          10.ph,

          AppButton(
            buttonHeight: 30,
            onPressed: () {
              sendToPage(
                context,
                UsersProfileView(
                  userModel: userModel,
                  postModel: ModelController.instance.postModel,
                ),
              );
            },
            title: 'View Profile',
            foregroundColor: Colors.black,
            bgColor: const Color(0xFFECECEC),
          )
        ],
      ),
    );
  }
}
