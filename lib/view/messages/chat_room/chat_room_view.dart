import 'package:flutter/material.dart';
import 'package:instagram_clone/controller/chat_controller/chat_controller.dart';
import '../../../core/constants/constants.dart';

import '../../../core/services/hive_services.dart';
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
  late String? chatId, receiverId;
  late UserModel currentUser;

  @override
  void initState() {
    super.initState();

    currentUser = HiveServices.getUserBox().get(Const.currentUser)!;

    generateAndSaveChatId();
    saveReceiverModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  generateAndSaveChatId() async {
    chatId = '${currentUser.userId}_${widget.userModel.userId}';
    // save the chat id offline
    await HiveServices.setChatId(chatId!);
  }

  saveReceiverModel() {
    // set receiver chat controller instance to be accessible everywhere

    ChatController.instance.receiverModel = widget.userModel;

    ChatController.instance.recieverId = widget.userModel.userId;

    if (widget.userModel.profileImage != null) {
      ChatController.instance.receiverImage = widget.userModel.profileImage;
    }
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
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       children: [
          //         UserProfileHeader(userModel: widget.userModel),
          //         20.ph,
          //         const ChatMessagesList(),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView(
              reverse: true,
              children: [
                const ChatMessagesList(),
                20.ph,
                UserProfileHeader(userModel: widget.userModel),
              ],
            ),
          ),

          // Expanded(child: ChatMessagesList()),
          const ChatTextField(),
        ],
      ),
    );
  }
}
