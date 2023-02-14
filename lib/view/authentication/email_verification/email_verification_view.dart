import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/utils/utils.dart';
import '../../../repository/respository_implementation/auth_implementation.dart';
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

  checkEmailVerification() {
    firebaseAuth.currentUser!.reload();
    setState(() => isEmailVerified = firebaseAuth.currentUser!.emailVerified);

    if (isEmailVerified) timer?.cancel();
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
