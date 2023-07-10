import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/model/reel_model/reel_model.dart';
import 'package:instagram_clone/view/add_post/preview_video.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../core/utils/utils.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/repository_abstract/storage_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';
import '../../repository/respository_implementation/storage_implementation.dart';
import '../../view/layout/app_layout.dart';

class ReelController extends GetxController {
  static ReelController instance = Get.find<ReelController>();

  var isLoading = false.obs;

  List<dynamic> media = [];

  static TextEditingController captionController = TextEditingController();

  // instantic all contract object
  StorageContract storageContract = StorageImplementation();
  FirestoreDB firestoreDB = FirestoreDBImpl();

  String reelId = FirestoreDBImpl.generateFirestoreId(Const.reelCollection);

  addNewReel() async {
    UserModel? userModel = HiveServices.getUserBox().get(Const.currentUser);

    ReelModel reelModel = ReelModel(
      id: reelId,
      userId: userModel!.userId,
      caption: captionController.text,
      media: media.first,
      timePosted: DateTime.now(),
    );

    try {
      Get.off(() => const AppLayoutView(pageIndex: 2));

      //   upload to firestore database
      await saveToDB(reelModel, userModel);

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

  getVideoAndPreview(String videoFile) {
    ReelController.instance.media.clear();
    ReelController.instance.media = [videoFile];
    // send user to video player page when user is done recording
    if (media.isNotEmpty) {
      Get.to(() => PreviewVideo(videoPath: videoFile));
    }
  }

  Future<void> saveToDB(ReelModel reelModel, UserModel userModel) async {
    await firestoreDB.addDocWithId(
      Const.reelCollection,
      reelId,
      reelModel.toJson(),
    );

    // PostController.instance.updateNumOfPostLocally();
  }

  Future<void> uploadMediaFiles() async {
    if (media.isNotEmpty) {
      for (var i = 0; i < media.length; i++) {
        bool isValidURL = Uri.parse(media[i]).isAbsolute;

        if (!isValidURL) {
          List<String> mediaUrls = await storageContract.uploadMultipleFiles(
            Const.reelCollection,
            reelId,
            ReelController.instance.media.map((data) => File(data)).toList(),
          );
          media = mediaUrls;
        }
      }
    }
  }

  Future<void> updateMediaUrl() async {
    await firestoreDB.updateDoc(
      Const.reelCollection,
      reelId,
      {'media': media.first},
    );
  }

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }
}
