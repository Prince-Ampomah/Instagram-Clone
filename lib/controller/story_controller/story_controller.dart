import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/model/story_model/story_model.dart';
import 'package:instagram_clone/view/home/story/story_image_preview.dart';
import 'package:instagram_clone/view/home/story/story_video_preview.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../core/utils/utils.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/repository_abstract/storage_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';
import '../../repository/respository_implementation/storage_implementation.dart';

class StoryController extends GetxController {
  static StoryController instance = Get.find<StoryController>();

  int countImagePreview = 0;

  onPageChanged(int i) {
    countImagePreview = i;
    update();
  }

  List<dynamic> media = [];

  // instantic all contract object
  StorageContract storageContract = StorageImplementation();
  FirestoreDB firestoreDB = FirestoreDBImpl();

  String storyId = FirestoreDBImpl.generateFirestoreId(Const.storyCollection);

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
      Get.to(() => const StoryImagePreview());
    }
  }

  getVideoAndPreview(String videoFile) {
    media.clear();
    media = [videoFile];
    // send user to video player page when user is done recording
    if (media.isNotEmpty) {
      Get.to(() => StoryVideoPreview(videoPath: media.first));
    }
  }

  getImageAndPreview(String imageFile) {
    media.clear();
    media = [imageFile];
    // send user to image view page when user tap on the
    if (media.isNotEmpty) {
      Get.to(() => const StoryImagePreview());
    }
  }

  addNewStory(String storyType) async {
    try {
      await saveStoryInDB(storyType);
      await uploadMediaFiles();
      await updateMediaUrl();
      media.clear();
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  Future<void> saveStoryInDB(String storyType) async {
    UserModel? currentUser = HiveServices.getUserBox().get(Const.currentUser);

    StoryModel storyModel = StoryModel(
      id: storyId,
      userId: currentUser?.userId,
      media: media,
      storyType: storyType,
      userProfileImage: currentUser?.profileImage,
      userHandle: currentUser!.userHandle,
      timePosted: DateTime.now(),
    );

    await firestoreDB.addDocWithId(
      Const.storyCollection,
      storyId,
      storyModel.toJson(),
    );
  }

  Future<void> uploadMediaFiles() async {
    if (media.isNotEmpty) {
      for (var i = 0; i < media.length; i++) {
        bool isValidURL = Uri.parse(media[i]).isAbsolute;

        if (!isValidURL) {
          List<String> mediaUrls = await storageContract.uploadMultipleFiles(
            Const.storyCollection,
            storyId,
            media.map((data) => File(data)).toList(),
          );
          media = mediaUrls;
        }
      }
    }
  }

  Future<void> updateMediaUrl() async {
    await firestoreDB
        .updateDoc(Const.storyCollection, storyId, {'media': media});
  }
}
