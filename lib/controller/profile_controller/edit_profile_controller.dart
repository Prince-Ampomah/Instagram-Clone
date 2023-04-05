import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/utils/utils.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';

class EditProfileController extends GetxController {
  static EditProfileController instance = Get.find<EditProfileController>();

  late TextEditingController fullnameController;
  late TextEditingController usernameController;
  late TextEditingController bioController;

  FirestoreDB firestoreDB = FirestoreDBImpl();

  UserModel? userInfo = HiveServices.getUserBox().get(Const.currentUser);

  updateFullname() async {
    try {
      if (fullnameController.text.isNotEmpty) {
        return await firestoreDB.updateDoc(
          Const.usersCollection,
          userInfo!.userId!,
          {
            'fullname': fullnameController.text,
          },
        );
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  updateUsername() async {
    try {
      if (usernameController.text.isNotEmpty) {
        return await firestoreDB.updateDoc(
          Const.usersCollection,
          userInfo!.userId!,
          {
            'userHandle': usernameController.text,
          },
        );
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  updateBio() async {
    try {
      if (bioController.text.isNotEmpty) {
        return await firestoreDB.updateDoc(
          Const.usersCollection,
          userInfo!.userId!,
          {
            'bio': bioController.text,
          },
        );
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
