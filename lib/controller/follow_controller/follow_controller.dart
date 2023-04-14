import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/notification_controller/notification_controller.dart';
import 'package:instagram_clone/model/notification_model/notification_model.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../core/utils/utils.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';

class FollowController extends GetxController {
  static FollowController instance = Get.find<FollowController>();

  FirestoreDB firestoreDB = FirestoreDBImpl();

  String notificationId =
      FirestoreDBImpl.generateFirestoreId(Const.notificationCollection);

  Future<void> followUser(String userToFollowId) async {
    UserModel? currentUser = HiveServices.getUserBox().get(Const.currentUser);

    try {
      if (!currentUser!.listOfFollowing!.contains(userToFollowId)) {
        await firestoreDB.updateDoc(
          Const.usersCollection,
          userToFollowId,
          {
            'listOfFollowers': FieldValue.arrayUnion([currentUser.userId]),
            'numberOfFollowers': FieldValue.increment(1),
          },
        );

        await updateFollowDataRemotely(userToFollowId, currentUser);

        NotificationController.instance.addNewNotification();
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  Future<void> unFollowUser(String userToUnFollowId) async {
    UserModel? currentUser = HiveServices.getUserBox().get(Const.currentUser);
    try {
      if (currentUser!.listOfFollowing!.contains(userToUnFollowId)) {
        await firestoreDB.updateDoc(
          Const.usersCollection,
          userToUnFollowId,
          {
            'listOfFollowers': FieldValue.arrayRemove([currentUser.userId]),
            'numberOfFollowers': FieldValue.increment(-1),
          },
        );

        await updateUnfollowDataRemotely(currentUser, userToUnFollowId);
      }
    } catch (e) {
      update();
      Utils.showErrorMessage(e.toString());
    }
  }

  /// update follow data remotely and locally
  Future<void> updateFollowDataRemotely(
    String userToFollowId,
    UserModel userModel,
  ) async {
    await firestoreDB.updateDoc(
      Const.usersCollection,
      userModel.userId!,
      {
        'listOfFollowing': FieldValue.arrayUnion([userToFollowId]),
        'numberOfFollowing': FieldValue.increment(1),
      },
    );

    await updateFollowDataLocally(userModel);
  }

  Future<void> updateFollowDataLocally(
    UserModel currentUser,
  ) async {
    //Query the new update from db and update locally
    DocumentSnapshot doc = await firestoreDB.getDocById(
      Const.usersCollection,
      currentUser.userId!,
    );

    if (doc.exists) {
      currentUser.listOfFollowing =
          UserModel.fromJson(doc.data() as Map<String, dynamic>)
              .listOfFollowing;
      currentUser.numberOfFollowing =
          UserModel.fromJson(doc.data() as Map<String, dynamic>)
              .numberOfFollowing;

      //save number of post locally
      await currentUser.save();
    }
  }

  /// update unfollow data remotely and locally
  Future<void> updateUnfollowDataRemotely(
    UserModel currentUser,
    String userToUnFollowId,
  ) async {
    // update the following list and number of following in the current data
    await firestoreDB.updateDoc(
      Const.usersCollection,
      currentUser.userId!,
      {
        'listOfFollowing': FieldValue.arrayRemove([userToUnFollowId]),
        'numberOfFollowing': FieldValue.increment(-1),
      },
    );

    // query the current user data and save it locally
    await updateUnfollowDataLocally(currentUser);
  }

  Future<void> updateUnfollowDataLocally(UserModel currentUser) async {
    // query the current user data and save it locally
    DocumentSnapshot doc = await firestoreDB.getDocById(
      Const.usersCollection,
      currentUser.userId!,
    );

    if (doc.exists) {
      currentUser.listOfFollowing =
          UserModel.fromJson(doc.data() as Map<String, dynamic>)
              .listOfFollowing;
      currentUser.numberOfFollowing =
          UserModel.fromJson(doc.data() as Map<String, dynamic>)
              .numberOfFollowing;

      await currentUser.save();
    }
  }
}
