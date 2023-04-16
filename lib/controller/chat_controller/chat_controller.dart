import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/model/chat_model/recent_chat_model.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../core/utils/utils.dart';
import '../../model/chat_model/chat_model.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';

class ChatController extends GetxController {
  static ChatController instance = Get.find<ChatController>();

  FirestoreDB firestoreDB = FirestoreDBImpl();

  static TextEditingController chatTextController = TextEditingController();
  static FocusNode chatTextFieldFocus = FocusNode();
  static ScrollController listController = ScrollController();

  String? recieverId, receiverImage;
  UserModel? receiverModel;

  sendTextMessage() async {
    try {
      if (chatTextController.text.trim().isNotEmpty) {
        String chatId = HiveServices.getChatId();

        String messageId =
            FirestoreDBImpl.generateFirestoreId(Const.chatCollection);

        ChatModel chatModel = ChatModel(
          messageId: messageId,
          chatId: chatId,
          message: chatTextController.text,
          messageType: 'text',
          senderId: FirebaseAuth.instance.currentUser!.uid,
          receiverId: ChatController.instance.recieverId,
          receiverImage: ChatController.instance.receiverImage,
          timeSent: DateTime.now(),
        );

        RecentChatModel recentChatModel = RecentChatModel(
          messageId: messageId,
          recentMessage: chatTextController.text,
          senderId: FirebaseAuth.instance.currentUser!.uid,
          receiverId: ChatController.instance.recieverId,
          receiverModel: ChatController.instance.receiverModel!,
          timeSent: DateTime.now(),
        );

        chatTextController.clear();

        await firestoreDB.addNestedDocsWithId(
          Const.chatCollection,
          chatId,
          Const.messagesCollection,
          messageId,
          {
            ...chatModel.toJson(),
            'timeSent': FieldValue.serverTimestamp(),
          },
        );

        await firestoreDB.addDocWithId(
          Const.chatCollection,
          chatId,
          {
            ...recentChatModel.toJson(),
            'timeSent': FieldValue.serverTimestamp(),
          },
        );
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  Future<UserModel> queryChatReceiverData() async {
    DocumentSnapshot doc = await firestoreDB.getDocById(
      Const.usersCollection,
      ChatController.instance.recieverId!,
    );

    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  @override
  void dispose() {
    chatTextController.dispose();
    chatTextFieldFocus.dispose();
    listController.dispose();
    super.dispose();
  }
}
