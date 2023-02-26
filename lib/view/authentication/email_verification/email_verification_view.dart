import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../controller/auth_controller/auth_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/utils/utils.dart';
import '../../../model/user_model/user_model.dart';
import '../../../repository/repository_abstract/database_abstract.dart';
import '../../../repository/respository_implementation/auth_implementation.dart';
import '../../../repository/respository_implementation/database_implementation.dart';
import '../../layout/app_layout.dart';
import 'verify_user_email_view.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  bool isEmailVerified = false;

  bool canResendLink = false;

  Timer? timer;

  FirestoreDB firestoreDB = FirestoreDBImpl();

  @override
  void initState() {
    super.initState();

    initEmailVerification();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void initEmailVerification() async {
    isEmailVerified = firebaseAuth.currentUser!.emailVerified;

    if (!isEmailVerified) await sendEmailVerification();

    timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) => checkEmailVerification(),
    );
  }

  Future<void> sendEmailVerification() async {
    try {
      await firebaseAuth.currentUser!.sendEmailVerification();
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  checkEmailVerification() async {
    try {
      firebaseAuth.currentUser!.reload();
      setState(() => isEmailVerified = firebaseAuth.currentUser!.emailVerified);

      if (isEmailVerified) {
        timer?.cancel();

        AuthController.instance.userModel.userId =
            firebaseAuth.currentUser!.uid;
        AuthController.instance.userModel.createdAt = DateTime.now();

        await firestoreDB.addDocWithId(
          Const.usersCollection,
          firebaseAuth.currentUser!.uid,
          AuthController.instance.userModel.toJson(),
        );

        //save user data offline
        var userBox = AuthController.instance.userBox;

        await userBox.put(Const.currentUser, AuthController.instance.userModel);

        userBox.get(Const.currentUser);
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? AppLayoutView()
        : VerifyUserEmailView(
            resendSendEmailLink: sendEmailVerification,
          );
  }
}
