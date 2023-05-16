import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/services/hive_services.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/core/widgets/cus_main_button.dart';
import 'package:instagram_clone/model/post_model/post_model.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';
import 'package:instagram_clone/view/core/follow_button.dart';
import 'package:instagram_clone/view/core/unfollow_button.dart';
import 'package:instagram_clone/view/messages/chat_room/chat_room_view.dart';

class FollowMessageAndContact extends StatelessWidget {
  const FollowMessageAndContact({
    super.key,
    required this.userModel,
    required this.postModel,
  });

  final UserModel userModel;
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          // listen to the user model hive box
          Expanded(
            child: ValueListenableBuilder<Box<UserModel>>(
              valueListenable: HiveServices.getUserBox().listenable(),
              builder: (BuildContext context, currentUserBox, _) {
                bool isInListOFFollowers = currentUserBox
                    .get(Const.currentUser)!
                    .listOfFollowing!
                    .contains(userModel.userId!);

                if (isInListOFFollowers) {
                  return UnfollowButton(userToUnfollowId: postModel.userId!);
                } else {
                  return FollowButton(userToFollowerId: postModel.userId!);
                }
              },
            ),
          ),

          10.pw,

          // message button
          Expanded(
            child: AppButton(
              buttonHeight: 36,
              // buttonWidth: 120,
              onPressed: () {
                sendToPage(context, ChatRoomView(userModel: userModel));
              },
              title: 'Message',
              foregroundColor: Colors.black,
              bgColor: AppColors.buttonBgColor,
              borderRadius: 8,
            ),
          ),

          10.pw,
          // icon
          Container(
            alignment: Alignment.center,
            width: 50,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.buttonBgColor,
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
    );
  }
}
