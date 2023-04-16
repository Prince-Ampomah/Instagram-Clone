import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../core/utils/utils.dart';
import '../../model/chat_model/chat_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';
import '../models_controller/models_controller.dart';

class ChatController extends GetxController {
  static ChatController instance = Get.find<ChatController>();

  FirestoreDB firestoreDB = FirestoreDBImpl();
  String id = FirestoreDBImpl.generateFirestoreId(Const.chatCollection);

  static TextEditingController chatTextController = TextEditingController();
  static FocusNode chatTextFieldFocus = FocusNode();
  static ScrollController listController = ScrollController();

  sendTextMessage() async {
    if (chatTextController.text.trim().isNotEmpty) {
      var currentUser = HiveServices.getUserBox().get(Const.currentUser);

      String chatId = HiveServices.getChatId();

      try {
        ChatModel chatModel = ChatModel(
          id: id,
          chatId: chatId,
          message: chatTextController.text,
          messageType: 'text',
          senderId: currentUser!.userId,
          receiverId: ModelController.instance.postModel.userId,
          timeSent: DateTime.now(),
        );

        await firestoreDB.addNestedDocsWithId(
          Const.chatCollection,
          chatId,
          Const.messagesCollection,
          id,
          {
            ...chatModel.toJson(),
            'timeSent': FieldValue.serverTimestamp(),
          },
        );

        chatTextController.clear();
      } catch (e) {
        Utils.showErrorMessage(e.toString());
      }
    }
  }

  @override
  void dispose() {
    chatTextController.dispose();
    chatTextFieldFocus.dispose();
    listController.dispose();
    super.dispose();
  }
}
