import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models_controller/models_controller.dart';
import '../../core/constants/constants.dart';
import '../../model/post_model/post_model.dart';

import '../../core/services/hive_services.dart';
import '../../core/utils/utils.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/repository_abstract/storage_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';
import '../../repository/respository_implementation/storage_implementation.dart';
import '../../view/add_post/add_new_post.dart';

class NewPostController extends GetxController {
  static NewPostController instance = Get.find<NewPostController>();

  List<dynamic> media = [];

  static TextEditingController captionController = TextEditingController();

  // instantic all contract object
  StorageContract storageContract = StorageImplementation();
  FirestoreDB firestoreDB = FirestoreDBImpl();

  String postId = FirestoreDBImpl.generateFirestoreId(Const.postsCollection);

  UserModel? userModel = HiveServices.getUserBox().get(Const.currentUser);

  Future<List<dynamic>> _pickMediaFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media, // will let you pick either video or images.
      // allowedExtensions: ["png", "jpg", "jpeg", 'mp4', 'mkv'],
    );
    if (result != null) {
      media.clear();
      media.addAll(result.paths);
    }
    return media;
  }

  pickMediaFromDevice() async {
    // inject new post controller
    // final newPostController = Get.put(NewPostController());
    List<dynamic> media = await _pickMediaFiles();

    if (media.isNotEmpty) {
      Get.to(() => const AddNewPost());
    }
  }

  addNewPost() async {
    PostModel postModel = PostModel(
      id: postId,
      caption: captionController.text,
      media: media,
      userModel: userModel!,
      commentModel: ModelController.instance.commentModel,
      likeModel: ModelController.instance.likeModel,
      location: ModelController.instance.postLocationModel,
    );

    try {
      // upload to firestore database
      await saveToDB(postModel);

      // upload media to frebase storage
      await uploadMediaFiles();

      // update the media fields in firestore database
      await updateMediaUrl();
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  Future<void> saveToDB(PostModel postModel) async {
    // upload to firestore database
    await firestoreDB.addDocWithId(
      Const.postsCollection,
      postId,
      postModel.toJson(),
    );
  }

  Future<void> uploadMediaFiles() async {
    if (media.isNotEmpty) {
      for (var i = 0; i < media.length; i++) {
        bool isValidURL = Uri.parse(media[i]).isAbsolute;

        if (!isValidURL) {
          List<String> mediaUrls = await storageContract.uploadMultipleFiles(
            Const.postsCollection,
            postId,
            NewPostController.instance.media.map((data) => File(data)).toList(),
          );
          media = mediaUrls;
        }
      }
    }
  }

  Future<void> updateMediaUrl() async {
    await firestoreDB
        .updateDoc(Const.postsCollection, postId, {'media': media});
  }

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }
}
