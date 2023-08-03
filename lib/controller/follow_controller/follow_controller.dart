import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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
          },
        );

        await updateFollowersListRemotely(userToFollowId, currentUser);
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
          },
        );

        await updateCurrentUserFollowingListDataRemotely(
            currentUser, userToUnFollowId);
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  /// update follow data remotely and locally
  Future<void> updateFollowersListRemotely(
    String userToFollowId,
    UserModel userModel,
  ) async {
    await firestoreDB.updateDoc(
      Const.usersCollection,
      userModel.userId!,
      {
        'listOfFollowing': FieldValue.arrayUnion([userToFollowId]),
      },
    );

    await saveFollowersListLocally(userModel);
  }

  Future<void> saveFollowersListLocally(
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

      //save number of post locally
      await currentUser.save();
    }
  }

  /// update unfollow data remotely and locally
  Future<void> updateCurrentUserFollowingListDataRemotely(
    UserModel currentUser,
    String userToUnFollowId,
  ) async {
    // remove the unfollowed user from the current user list of following
    await firestoreDB.updateDoc(
      Const.usersCollection,
      currentUser.userId!,
      {
        'listOfFollowing': FieldValue.arrayRemove([userToUnFollowId]),
      },
    );

    // query the current user data and save it locally
    await saveListOfFollowingLocally(currentUser);
  }

  Future<void> saveListOfFollowingLocally(UserModel currentUser) async {
    // query the current user data and save it locally
    DocumentSnapshot doc = await firestoreDB.getDocById(
      Const.usersCollection,
      currentUser.userId!,
    );

    if (doc.exists) {
      currentUser.listOfFollowing =
          UserModel.fromJson(doc.data() as Map<String, dynamic>)
              .listOfFollowing;

      await currentUser.save();
    }
  }
}
