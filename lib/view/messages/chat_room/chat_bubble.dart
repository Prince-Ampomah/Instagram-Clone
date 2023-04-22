import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';
import 'package:instagram_clone/view/messages/chat_room/chat_image_bubble.dart';
import 'package:instagram_clone/view/messages/chat_room/chat_text_bubble.dart';

import '../../../core/constants/constants.dart';
import '../../../model/chat_model/chat_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.chatModel}) : super(key: key);

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 8.0),
      child: chatModel.messageType == Const.textType
          ? ChatBubbleTextMessage(chatModel: chatModel)
          : ChatBubbleImageMessage(chatModel: chatModel),
    );
  }
}