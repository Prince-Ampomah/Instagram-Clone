import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/model/chat_model/recent_chat_model.dart';
import 'package:instagram_clone/view/messages/core/chat_preview_image.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/utils.dart';
import '../../model/chat_model/chat_model.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/repository_abstract/storage_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';
import '../../repository/respository_implementation/storage_implementation.dart';
import '../../view/messages/core/chat_preview_video.dart';

enum ChatType {
  text,
  image,
  audio,
  video,
}

class ChatController extends GetxController {
  static ChatController instance = Get.find<ChatController>();

  FirestoreDB firestoreDB = FirestoreDBImpl();
  StorageContract storageContract = StorageImplementation();

  static TextEditingController chatTextController = TextEditingController();
  static FocusNode chatTextFieldFocus = FocusNode();
  static ScrollController listController = ScrollController();

  bool isTyping = false;

  // init image count used as a smooth page indicator
  int countImagePreview = 0;

  // chat receiver variables
  String? recieverId, receiverImage;
  UserModel? receiverModel;

  List<dynamic>? chatMedia = [];

  onPageChanged(int i) {
    countImagePreview = i;
    update();
  }

  void addListenerToChatTextField() {
    chatTextController.addListener(() {
      isTyping = chatTextController.text.trim().isNotEmpty;
      update();
    });
  }

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
          messageType: 'text',
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

  sendMediaMessage(String messageType) async {
    try {
      if (chatMedia!.isNotEmpty) {
        String chatId = HiveServices.getChatId();

        String messageId =
            FirestoreDBImpl.generateFirestoreId(Const.chatCollection);

        ChatModel chatModel = ChatModel(
          messageId: messageId,
          chatId: chatId,
          message: chatTextController.text,
          messageType: messageType,
          media: chatMedia,
          senderId: FirebaseAuth.instance.currentUser!.uid,
          receiverId: ChatController.instance.recieverId,
          receiverImage: ChatController.instance.receiverImage,
          timeSent: DateTime.now(),
        );

        RecentChatModel recentChatModel = RecentChatModel(
          messageId: messageId,
          recentMessage: 'media',
          messageType: messageType,
          senderId: FirebaseAuth.instance.currentUser!.uid,
          receiverId: ChatController.instance.recieverId,
          receiverModel: ChatController.instance.receiverModel!,
          timeSent: DateTime.now(),
        );

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

        await uploadMediaFiles();

        await updateMediaUrl(messageId);

        chatMedia!.clear();
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  getVideoAndPreview(String videoFile) {
    ChatController.instance.chatMedia!.clear();
    ChatController.instance.chatMedia = [videoFile];
    // send user to video player page when user is done recording
    Get.to(
      () => ChatPreviewVideo(
        videoPath: ChatController.instance.chatMedia!.first,
        showSendButton: true,
      ),
    );
  }

  getImageAndPreview(String imageFile) {
    ChatController.instance.chatMedia!.clear();
    ChatController.instance.chatMedia = [imageFile];

    // send user to image view page when user tap on the
    Get.to(
      () => const ChatImagePreview(isFromGallery: false),
    );
  }

  Future<List<dynamic>> _pickImagesFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ["png", "jpg", "jpeg"],
    );

    if (result != null) {
      chatMedia!.clear();

      chatMedia!.addAll(result.paths);
    }

    return chatMedia!;
  }

  pickImagesFromGallery() async {
    chatMedia = await _pickImagesFromGallery();

    if (chatMedia!.isNotEmpty) {
      Get.to(() => const ChatImagePreview());
    }
  }

  pickImageFromCamera() async {
    chatMedia = [await getImagePicker(ImageSource.camera)];
    if (chatMedia!.isNotEmpty) {
      Get.to(() => const ChatImagePreview());
    }
  }

  Future<void> uploadMediaFiles() async {
    String chatId = HiveServices.getChatId();
    if (chatMedia!.isNotEmpty) {
      for (var i = 0; i < chatMedia!.length; i++) {
        bool isValidURL = Uri.parse(chatMedia![i]).isAbsolute;

        if (!isValidURL) {
          List<String> mediaUrls = await storageContract.uploadMultipleFiles(
            Const.chatCollection,
            chatId,
            ChatController.instance.chatMedia!
                .map((data) => File(data))
                .toList(),
          );
          chatMedia = mediaUrls;
        }
      }
    }
  }

  Future<void> updateMediaUrl(String messageId) async {
    String chatId = HiveServices.getChatId();
    await firestoreDB.updateNestedDocs(
      Const.chatCollection,
      chatId,
      Const.messagesCollection,
      messageId,
      {'media': chatMedia},
    );
  }

  deleteChatMessage(String messageId) async {
    String chatId = HiveServices.getChatId();

    try {
      await firestoreDB.deleteNestedDocsWithId(
        Const.chatCollection,
        chatId,
        Const.messagesCollection,
        messageId,
      );
    } catch (e) {
      Utils.showErrorMessage(e.toString());
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
