import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/utils/utils.dart';

import '../../core/services/hive_services.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';

class FollowController extends GetxController {
  static FollowController instance = Get.find<FollowController>();

  FirestoreDB firestoreDB = FirestoreDBImpl();

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

        await updateCurrentUserListOFFollowing(userToFollowId, currentUser);
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

        await firestoreDB.updateDoc(
          Const.usersCollection,
          currentUser.userId!,
          {
            'listOfFollowing': FieldValue.arrayRemove([userToUnFollowId]),
            'numberOfFollowing': FieldValue.increment(-1),
          },
        );

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

          update();
        }
      }
    } catch (e) {
      update();
      Utils.showErrorMessage(e.toString());
    }
  }

  Future<void> updateCurrentUserListOFFollowing(
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

    await updateCurrentUserFollowingDataLocally(userModel);
  }

  Future<void> updateCurrentUserFollowingDataLocally(
    UserModel userModel,
  ) async {
    //Query the new update from db and update locally
    DocumentSnapshot doc = await firestoreDB.getDocById(
      Const.usersCollection,
      userModel.userId!,
    );

    if (doc.exists) {
      userModel.listOfFollowing =
          UserModel.fromJson(doc.data() as Map<String, dynamic>)
              .listOfFollowing;
      userModel.numberOfFollowing =
          UserModel.fromJson(doc.data() as Map<String, dynamic>)
              .numberOfFollowing;

      //save number of post locally
      await userModel.save();
    }
  }
}
