import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/utils.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/repository_abstract/storage_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';
import '../../repository/respository_implementation/storage_implementation.dart';

class EditProfileController extends GetxController {
  static EditProfileController instance = Get.find<EditProfileController>();

  bool isLoading = false;

  late TextEditingController fullnameController;
  late TextEditingController usernameController;
  late TextEditingController bioController;

  FirestoreDB firestoreDB = FirestoreDBImpl();

  StorageContract storageContract = StorageImplementation();

  UserModel? userInfo = HiveServices.getUserBox().get(Const.currentUser);
// var  post = HiveServices.getPosts();

  void getUserProfilePic(imageSource) async {
    var imagePath = await getImagePicker(imageSource);
    if (imagePath.isNotEmpty) {
      userInfo!.profileImage = imagePath;
      update();
    }

    // remove the bottom sheet
    Get.back();
  }

  updateProfilePicture(String profileImage) async {
    try {
      if (profileImage.isNotEmpty) {
        var postId = HiveServices.getPostId();
        bool isValidURL = Uri.parse(profileImage).isAbsolute;

        isLoading = true;
        update();

        if (!isValidURL) {
          profileImage = await storageContract.uploadFile(
            Const.usersCollection,
            userInfo!.userId!,
            File(profileImage),
          );
        }

        await firestoreDB.updateDoc(
          Const.usersCollection,
          userInfo!.userId!,
          {
            'profileImage': profileImage,
          },
        );

        await firestoreDB.updateDoc(
          Const.postsCollection,
          postId,
          {
            'user.profileImage': profileImage,
          },
        );

        userInfo!.profileImage = profileImage;
        await userInfo!.save();

        isLoading = false;
        update();

        Utils.showSuccessMessage('Profile Updated');
        Get.back();
      }
    } catch (e) {
      isLoading = false;
      update();
      Utils.showErrorMessage(e.toString());
    }
  }

  updateFullname() async {
    try {
      if (fullnameController.text.isNotEmpty) {
        var postId = HiveServices.getPostId();
        await firestoreDB.updateDoc(
          Const.usersCollection,
          userInfo!.userId!,
          {
            'fullname': fullnameController.text,
          },
        );

        await firestoreDB.updateDoc(
          Const.postsCollection,
          postId,
          {
            'user.fullname': fullnameController.text,
          },
        );

        userInfo!.fullname = fullnameController.text;
        await userInfo!.save();

        Get.back();
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  updateUsername() async {
    try {
      if (usernameController.text.isNotEmpty) {
        var postId = HiveServices.getPostId();
        await firestoreDB.updateDoc(
          Const.usersCollection,
          userInfo!.userId!,
          {
            'userHandle': usernameController.text,
          },
        );

        await firestoreDB.updateDoc(
          Const.postsCollection,
          postId,
          {
            'user.userHandle': usernameController.text,
          },
        );

        userInfo!.userHandle = usernameController.text;
        await userInfo!.save();
        Get.back();
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  updateBio() async {
    try {
      if (bioController.text.isNotEmpty) {
        var postId = HiveServices.getPostId();
        await firestoreDB.updateDoc(
          Const.usersCollection,
          userInfo!.userId!,
          {
            'bio': bioController.text,
          },
        );

        await firestoreDB.updateDoc(
          Const.postsCollection,
          postId,
          {
            'user.bio': bioController.text,
          },
        );

        userInfo!.bio = bioController.text;
        await userInfo!.save();
        Get.back();
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  @override
  void dispose() {
    fullnameController.dispose();
    usernameController.dispose();
    bioController.dispose();
    super.dispose();
  }
}
