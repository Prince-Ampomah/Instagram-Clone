import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../controller/auth_controller/auth_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/services/hive_services.dart';
import '../../../core/utils/utils.dart';
import '../../../model/user_model/user_model.dart';
import '../../../repository/repository_abstract/database_abstract.dart';
import '../../../repository/repository_abstract/storage_abstract.dart';
import '../../../repository/respository_implementation/auth_implementation.dart';
import '../../../repository/respository_implementation/database_implementation.dart';
import '../../../repository/respository_implementation/storage_implementation.dart';
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

  late Timer? timer;

  FirestoreDB firestoreDB = FirestoreDBImpl();

  StorageContract storageContract = StorageImplementation();

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
      const Duration(seconds: 5),
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

        UserModel userModel = UserModel(
          userId: firebaseAuth.currentUser!.uid,
          fullname: AuthController.instance.userModel.fullname,
          userHandle: AuthController.instance.userModel.userHandle,
          email: AuthController.instance.userModel.email,
          isEmailVerified: isEmailVerified,
          profileImage: AuthController.instance.userModel.profileImage,
          phoneNumber: AuthController.instance.userModel.phoneNumber,
          createdAt: DateTime.now(),
        );

        await firestoreDB.addDocWithId(
          Const.usersCollection,
          firebaseAuth.currentUser!.uid,
          userModel.toJson(),
        );

        await uploadProfilePicToStorage();

        //save user data offline
        Box<UserModel> userBox = HiveServices.getUserBox();
        await userBox.put(Const.currentUser, userModel);

        Get.off(() => AppLayoutView(pageIndex: 0));
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  Future<void> uploadProfilePicToStorage() async {
    if (AuthController.instance.userModel.profileImage!.isNotEmpty) {
      bool isValidURL =
          Uri.parse(AuthController.instance.userModel.profileImage!).isAbsolute;

      if (!isValidURL) {
        String url = await storageContract.uploadFile(
          Const.usersCollection,
          firebaseAuth.currentUser!.uid,
          File(AuthController.instance.userModel.profileImage!),
        );
        AuthController.instance.userModel.profileImage = url;
      }

      await updateMediaUrl();
    }
  }

  Future<void> updateMediaUrl() async {
    await firestoreDB
        .updateDoc(Const.usersCollection, firebaseAuth.currentUser!.uid, {
      'profileImage': AuthController.instance.userModel.profileImage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? AppLayoutView()
        : VerifyUserEmailView(resendSendEmailLink: sendEmailVerification);
  }
}
