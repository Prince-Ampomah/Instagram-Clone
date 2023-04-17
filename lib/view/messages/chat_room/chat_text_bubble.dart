import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/controller/chat_controller/chat_controller.dart';
import 'package:instagram_clone/controller/models_controller/models_controller.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/view/profile/users_profile/users_profile_view.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_read_more_text.dart';
import '../../../model/chat_model/chat_model.dart';

class ChatBubbleTextMessage extends StatelessWidget {
  const ChatBubbleTextMessage({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    bool isMe = chatModel.senderId == FirebaseAuth.instance.currentUser!.uid;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe && chatModel.receiverImage != null)
          GestureDetector(
            onTap: () {
              sendToPage(
                context,
                UsersProfileView(
                  userModel: ChatController.instance.receiverModel,
                  postModel: ModelController.instance.postModel,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CustomCachedImage(
                  height: 35,
                  width: 35,
                  imageUrl: chatModel.receiverImage!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              right: isMe ? 10.0 : 80.0,
              left: isMe ? 80.0 : 10.0,
              bottom: 10.0,
            ),
            padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
            decoration: BoxDecoration(
              color: isMe ? AppColors.chatColor : AppColors.buttonBgColor,
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
            ),
            child: CustomReadMore(
              text: chatModel.message!,
              textStyle: TextStyle(
                color: isMe ? AppColors.whiteColor : AppColors.blackColor,
              ),
              trimLines: 4,
              readMoreText: ' Read More',
              readLessText: ' Read Less',
            ),
          ),
        ),
      ],
    );
  }
}
