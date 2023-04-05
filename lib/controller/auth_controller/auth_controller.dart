import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../core/constants/constants.dart';
import '../../core/services/hive_services.dart';
import '../../core/utils/utils.dart';
import '../../model/user_model/user_model.dart';
import '../../repository/repository_abstract/auth_abstract.dart';
import '../../repository/repository_abstract/database_abstract.dart';
import '../../repository/respository_implementation/auth_implementation.dart';
import '../../repository/respository_implementation/database_implementation.dart';
import '../../view/authentication/email_verification/email_verification_view.dart';
import '../../view/layout/app_layout.dart';

class AuthController extends GetxController {
  //auth controller instance
  static AuthController instance = Get.find();

  var isLoading = false.obs;

  Timer? timer;

  late UserCredential userCredential;

  UserModel userModel = UserModel();

  // initalize the auth abstract class to its implementation
  final AuthContract _authContract = Authimplementation();
  final FirestoreDB _firestoreDB = FirestoreDBImpl();

  signUserIn(String email, String password) async {
    try {
      isLoading(true);
      userCredential =
          await _authContract.signInWithEmailAndPassword(email, password);

      if (userCredential.user!.uid.isNotEmpty) {
        String userId = userCredential.user!.uid;
        DocumentSnapshot doc =
            await _firestoreDB.getDocById(Const.usersCollection, userId);

        if (doc.exists) {
          UserModel userModel =
              UserModel.fromJson(doc.data() as Map<String, dynamic>);

          Box<UserModel> userBox = HiveServices.getUserBox();

          await userBox.put(Const.currentUser, userModel);

          Get.off(() => AppLayoutView(pageIndex: 0));
        }
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Utils.showErrorMessage(e.toString());
    }
  }

  signUserUp(String email, String password) async {
    try {
      isLoading(true);

      await _authContract.signUpWithEmailAndPassword(email, password);

      Get.off(() => const EmailVerificationView());

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Utils.showErrorMessage(e.toString());
    }
  }

  resetUserPassword(String email) async {
    try {
      await _authContract.resetPassword(email);
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  Future<void> signOutUser() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }

  Future<void> deleteUserFromAuth() async {
    try {
      if (userCredential.user != null) {
        await userCredential.user!.delete();
      }
    } catch (e) {
      Utils.showErrorMessage(e.toString());
    }
  }
}

  // late Rx<User?> _user;
/**
 *   @override
  void onReady() {
    // set the the firebase current user to the [Rx<User>] type
    _user = Rx<User?>(firebaseAuth.currentUser);

    // listen auth changes (sign-in or sign-out)
    _user.bindStream(firebaseAuth.userChanges());

    // called every time [listener] changes. As long as the [condition] returns true
    ever(_user, (user) => _initialScreen(user));

    super.onReady();
  }

  _initialScreen(User? user) {
    if (user != null) {
      Get.offAll(() => AppLayoutView());
    } else {
      // Get.offAll(const SignInView());

      Get.offAll(() => const SignInView());
    }
  }


 */


/**
 * 
      if (!userCredential.user!.emailVerified) {
        await firebaseAuth.currentUser!.sendEmailVerification();
        timer = Timer.periodic(const Duration(seconds: 3), (_) async {
          await firebaseAuth.currentUser!.reload();
          logger.d(firebaseAuth.currentUser);
          if (userCredential.user!.emailVerified) timer?.cancel();
        });

        // Future.delayed(const Duration(seconds: 10)).then((value) async {
        //   await firebaseAuth.currentUser!.reload();
        //   logger.d(firebaseAuth.currentUser);
        // });
      }

      logger.d(userCredential);
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        Get.defaultDialog(
          title: 'Email Verification',
          content: const Text(
            'A verification link has been sent to the email you provided',
          ),
          onConfirm: () async {
            userCredential.user!.sendEmailVerification().then((value) {
              print(userCredential.user!.emailVerified);
              firebaseAuth.currentUser!.reload();
              Get.back();
            });
          },
          onCancel: () => Get.back(),
          barrierDismissible: false,
        );
      }
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
     
 */