import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';

import '../../../controller/chat_controller/chat_controller.dart';
import '../../../controller/models_controller/models_controller.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_focus_menu.dart';
import '../../../model/chat_model/chat_model.dart';
import '../../profile/users_profile/users_profile_view.dart';
import 'chat_image_bubble_details.dart';

class ChatBubbleImageMessage extends StatelessWidget {
  const ChatBubbleImageMessage({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    bool isMe = chatModel.senderId == FirebaseAuth.instance.currentUser!.uid;
    return CustomFocusMenu(
      onPressed: () {},
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
          onPressed: () {},
          title: const Text('Reply'),
          trailingIcon: const Icon(Icons.reply_outlined),
        ),
        FocusedMenuItem(
          onPressed: () {},
          title: const Text('Forward'),
          trailingIcon: const Icon(Icons.near_me_outlined),
        ),
        FocusedMenuItem(
          onPressed: () {},
          title: const Text('Save'),
          trailingIcon: const Icon(Icons.download_outlined),
        ),
        FocusedMenuItem(
          onPressed: () {
            ChatController.instance.deleteChatMessage(chatModel.messageId!);
          },
          title: const Text(
            'Unsend',
            style: TextStyle(color: Colors.redAccent),
          ),
          trailingIcon: const Icon(
            Icons.delete_outline,
            color: Colors.redAccent,
          ),
        ),
      ],
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
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
                padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomCachedImage(
                    height: 30,
                    width: 30,
                    imageUrl: chatModel.receiverImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                sendToPage(
                  context,
                  ChatImageDetails(chatMedia: chatModel.media),
                );
              },
              child: Container(
                // height: 200,
                margin: EdgeInsets.only(
                  right: isMe ? 10.0 : 170.0,
                  left: isMe ? 170.0 : 10.0,
                  bottom: 10.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CustomCachedImage(
                    imageUrl: chatModel.media!.first!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
