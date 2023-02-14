import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../repository/respository_implementation/auth_implementation.dart';
import '../../view/authentication/sign_in_view/sign_in_view.dart';
import '../../view/authentication/email_verification/email_verification_view.dart';

class AuthListener extends StatelessWidget {
  const AuthListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        // logger.i(firebaseAuth.currentUser);

        if (snapshot.hasData) {
          return const EmailVerificationView();
        } else {
          return const SignInView();
        }
      },
    );
  }
}
