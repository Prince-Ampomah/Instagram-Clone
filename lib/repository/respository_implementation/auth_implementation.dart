import 'package:firebase_auth/firebase_auth.dart';

import '../../core/constants/constants.dart';
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
          throw ('The account already exists for that email');

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
          throw ('This email is not found, you will up to sign up');

        case 'network-request-failed':
          throw ('No internet connection');

        default:
          throw ('Your are disabled from the admin Contact the admin');
      }
    } catch (e) {
      throw (e.toString());
    }
  }
}
