import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/utils/utils.dart';
import 'package:instagram_clone/model/notification_model/notification_model.dart';

import '../../core/constants/constants.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/respository_implementation/database_implementation.dart';

class NotificationController extends GetxController {
  FirestoreDB firestoreDB = FirestoreDBImpl();

  static NotificationController instance = Get.find<NotificationController>();

  String notificationId =
      FirestoreDBImpl.generateFirestoreId(Const.notificationCollection);

  StreamSubscription? _streamSubscription;
  bool hasError = false, hasData = true, waiting = true, done = false;

  //Initialize Setters;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _setNotificationList = [];
  String _setTextState = '';

  //Initialize getters
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get getNotificationList =>
      _setNotificationList;
  String get getTextState => _setTextState;

  NotificationController() {
    getNotifications();
  }

  getNotifications() async {
    // var postBox = HiveServices.getPosts();

    return _streamSubscription = FirebaseFirestore.instance
        .collection(Const.notificationCollection)
        // .where('userId', isNotEqualTo: userModel!.userId)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((data) async {
      _setNotificationList = data.docs.toList();

      // Map<String, PostModel> postChanges = {};
      // List<String> postsRemoved = [];

      // for (var docRef in data.docChanges) {
      //   if (docRef.type == DocumentChangeType.removed) {
      //     postsRemoved.add(docRef.doc.id);
      //   } else {
      //     postChanges[docRef.doc.id] = PostModel.fromJson({
      //       ...docRef.doc.data()!,
      //     });
      //   }
      // }
      // // save post offline
      // await postBox.putAll(postChanges);

      // // delete all post data from offline db
      // //that has been deleted online
      // await postBox.deleteAll(postsRemoved);

      if (_setNotificationList!.isEmpty) {
        hasData = false;
        _setTextState = 'No Notification';
        update();
      }
      waiting = false;
      update();
    }, onError: (Object error, StackTrace stackTrace) {
      hasError = true;
      _setTextState = 'Something went wrong: $error';
      update();
    }, onDone: () {
      done = true;
      update();
    });
  }

  cancelSubscription() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
    }
  }

  @override
  void dispose() {
    cancelSubscription();
    super.dispose();
  }

  addNewNotification(String userToFollowId) async {
    // UserModel? currentUser = HiveServices.getUserBox().get(Const.currentUser);

    try {
      DocumentSnapshot doc = await firestoreDB.getDocById(
        Const.usersCollection,
        userToFollowId,
      );

      if (doc.exists) {
        UserModel? userModel =
            UserModel.fromJson(doc.data() as Map<String, dynamic>);

        NotificationModel notificationModel = NotificationModel(
          id: notificationId,
          userId: userModel.userId,
          userImage: userModel.profileImage,
          userHandle: userModel.userHandle,
          userFullName: userModel.fullname,
          date: DateTime.now(),
        );

        await firestoreDB.addDocWithId(
          Const.notificationCollection,
          notificationId,
          {
            ...notificationModel.toJson(),
            'date': FieldValue.serverTimestamp(),
          },
        );
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }
}
