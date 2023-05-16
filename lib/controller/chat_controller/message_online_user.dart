import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';

class MessageOnlineUsersController extends ChangeNotifier {
  StreamSubscription? _streamSubscription;
  bool hasError = false, hasData = true, waiting = true, done = false;

  //Initialize Setters;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _setUserOnlineList = [];
  String _setTextState = '';

  //Initialize getters
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get getUserOnlineList =>
      _setUserOnlineList;
  String get getTextState => _setTextState;

  MessageOnlineUsersController() {
    queryOnlineUsers();
  }

  queryOnlineUsers() async {
    var user = HiveServices.getUserBox().get(Const.currentUser);

    FirebaseFirestore.instance
        .collection(Const.usersCollection)
        .doc('userId')
        .get();

    return _streamSubscription = FirebaseFirestore.instance
        .collection(Const.usersCollection)
        .where('listOfFollowing', whereIn: user!.listOfFollowing)
        .snapshots()
        .listen((data) async {
      _setUserOnlineList = data.docs.toList();

      notifyListeners();

      if (_setUserOnlineList!.isEmpty) {
        hasData = false;
        _setTextState = 'No User is online';

        notifyListeners();
      }
      waiting = false;

      notifyListeners();
    }, onError: (Object error, StackTrace stackTrace) {
      hasError = true;
      _setTextState = 'Something went wrong: $error';

      notifyListeners();
    }, onDone: () {
      done = true;

      notifyListeners();
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
}
