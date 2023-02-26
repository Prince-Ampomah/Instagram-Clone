import 'package:firebase_auth/firebase_auth.dart';

import '../repository_abstract/auth_abstract.dart';

// global firebase auth which is accessible from everywhere
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class Authimplementation implements AuthContract {
  @override
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw ('Password should be at least 6 characters');

        case 'email-already-in-use':
          throw ('An account already exist for that email');

        case 'invalid-email':
          throw ('Email provided is invalid');

        case 'network-request-failed':
          throw ('No internet connection');

        default:
          throw ('Authentication not enabled. Contact the admin');
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          throw ('The password provided is wrong');

        case 'invalid-email':
          throw ('Email provided is invalid');

        case 'user-not-found':
          throw ('This email is not found, create a new account');

        case 'network-request-failed':
          throw ('No internet connection');

        default:
          throw ('Your are disabled from the admin Contact the admin');
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'auth/invalid-email':
          throw ('Email provided is invalid.');

        case 'auth/missing-android-pkg-name':
          throw ('An Android package name must be provided if the Android app is required to be installed.');

        case 'auth/missing-continue-uri':
          throw ('A continue URL must be provided in the request.');

        case 'auth/missing-ios-bundle-id':
          throw ('An iOS Bundle ID must be provided if an App Store ID is provided.');

        case 'auth/invalid-continue-uri':
          throw ('The continue URL provided in the request is invalid.');

        case 'auth/unauthorized-continue-uri':
          throw ('The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console.');

        default:
          throw ('There is no user corresponding to the email address. ');
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<void> confirmPasswordReset(String code, String newPassword) async {
    try {
      await firebaseAuth.confirmPasswordReset(
          code: code, newPassword: newPassword);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'expired-action-code':
          throw ('Code has expired');

        case 'user-disabled':
          throw ('Thrown if the user corresponding to the given action code has been disabled.');

        case 'invalid-action-code':
          throw ('Thrown if the action code is invalid. This can happen if the code is malformed or has already been used.');

        case 'user-not-found':
          throw ('There is no user corresponding to the action code');

        // case 'weak-password':
        //   throw ('Password be at least 6 min');
        default:
          throw ('Password be at least 6 min');
      }
    } catch (e) {
      throw (e.toString());
    }
  }
}
