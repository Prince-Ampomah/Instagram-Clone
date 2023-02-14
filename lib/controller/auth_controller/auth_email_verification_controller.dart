import 'dart:async';

import 'package:get/get.dart';

import '../../repository/respository_implementation/auth_implementation.dart';

class AuthEmailVerificationController extends GetxController {
  var isEmailVerified = false.obs;

  Timer? timer;

  @override
  void onInit() {
    isEmailVerified.value = firebaseAuth.currentUser!.emailVerified;
    if (!isEmailVerified.value) {
      sendEmailVerification();
    }

    timer = Timer.periodic(
        const Duration(seconds: 4), (_) => checkEmailVerification());

    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  sendEmailVerification() async {
    await firebaseAuth.currentUser!.sendEmailVerification();
  }

  checkEmailVerification() {
    firebaseAuth.currentUser!.reload();

    isEmailVerified.value = firebaseAuth.currentUser!.emailVerified;

    if (isEmailVerified.value) timer?.cancel();
  }
}
