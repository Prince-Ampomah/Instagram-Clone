import 'package:flutter/material.dart';
import 'package:instagram_clone/controller/chat_controller/chat_controller.dart';
import 'package:instagram_clone/view/comments/comment_text_field.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/helper_functions.dart';
import '../../profile/users_profile/users_profile_view.dart';

import '../../../controller/models_controller/models_controller.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../../core/widgets/cus_circular_image.dart';
import '../../../core/widgets/cus_main_button.dart';
import '../../../model/user_model/user_model.dart';
import 'chat_messages_list.dart';
import 'chat_room_appbar.dart';
import 'chat_room_profile_header.dart';
import 'chat_textfield.dart';

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  late String? chatId;
  late UserModel currentUser;

  @override
  void initState() {
    super.initState();

    currentUser = HiveServices.getUserBox().get(Const.currentUser)!;

    generateAndSaveChatId();
  }

  generateAndSaveChatId() async {
    chatId = '${currentUser.userId}_${widget.userModel.userId}';
    await HiveServices.setChatId(chatId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ChatRoomAppBar(userModel: widget.userModel),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              controller: ChatController.listController,
              children: [
                UserProfileHeader(userModel: widget.userModel),
                20.ph,
                const ChatMessagesList(),
              ],
            ),
          ),
          const ChatTextField(),
        ],
      ),
    );
  }
}
