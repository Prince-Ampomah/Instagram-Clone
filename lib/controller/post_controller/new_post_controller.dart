import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../core/utils/utils.dart';
import '../../model/post_model/post_location_model.dart';
import '../../model/post_model/post_model.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/repository_abstract/storage_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';
import '../../repository/respository_implementation/storage_implementation.dart';
import '../../view/add_post/add_new_post.dart';
import '../../view/layout/app_layout.dart';

class NewPostController extends GetxController {
  static NewPostController instance = Get.find<NewPostController>();

  var isLoading = false.obs;

  List<dynamic> media = [];

  static TextEditingController captionController = TextEditingController();

  // instantic all contract object
  StorageContract storageContract = StorageImplementation();
  FirestoreDB firestoreDB = FirestoreDBImpl();

  String postId = FirestoreDBImpl.generateFirestoreId(Const.postsCollection);

  Future<List<dynamic>> _pickMediaFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom, // will let you pick either video or images.
      allowedExtensions: [
        "png",
        "jpg",
        "jpeg",
      ], //["png", "jpg", "jpeg", 'mp4', 'mkv'],
    );

    if (result != null) {
      media.clear();
      // for (var element in result.paths) {
      //   media.add(element);
      // }
      media.addAll(result.paths); //.whereType<String>()

      //_TypeError (type 'List<String?>' is not a subtype of type 'Iterable<String>' of 'iterable'). Fix this error for me in flutter
    }
    return media;
  }

  pickMediaFromDevice() async {
    List<dynamic> media = await _pickMediaFiles();

    if (media.isNotEmpty) {
      Get.to(() => const AddNewPost());
    }
  }

  addNewPost() async {
    UserModel? userModel = HiveServices.getUserBox().get(Const.currentUser);

    PostModel postModel = PostModel(
      id: postId,
      userId: userModel!.userId,
      caption: captionController.text,
      media: media,
      location: PostLocationModel(),
      timePosted: DateTime.now(),
    );

    try {
      Get.off(() => const AppLayoutView(pageIndex: 0));
      //   upload to firestore database
      await saveToDB(postModel, userModel);

      // upload media to frebase storage
      await uploadMediaFiles();

      // update the media fields in firestore database
      await updateMediaUrl();

      captionController.clear();
      media.clear();
    } catch (e) {
      Get.back();
      Utils.showErrorMessage(e.toString());
    }
  }

  Future<void> saveToDB(PostModel postModel, UserModel userModel) async {
    await firestoreDB.addDocWithId(
      Const.postsCollection,
      postId,
      postModel.toJson(),
    );

    await updateNumberOfPost(userModel);
  }

  Future<void> updateNumberOfPost(UserModel userModel) async {
    await firestoreDB.updateDoc(
      Const.usersCollection,
      userModel.userId!,
      {
        'numberOfPost': FieldValue.increment(1),
      },
    );

    //Query the new update from db and update locally
    DocumentSnapshot doc = await firestoreDB.getDocById(
      Const.usersCollection,
      userModel.userId!,
    );

    if (doc.exists) {
      userModel.numberOfPost =
          UserModel.fromJson(doc.data() as Map<String, dynamic>).numberOfPost;
      //save number of post locally
      await userModel.save();
    }
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
