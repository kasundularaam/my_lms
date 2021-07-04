import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_lms/data/models/lms_user_model.dart';

class FirebaseRepo {
  static Future<void> loginWithEmailAndpswd(
      {required FirebaseAuth firebaseAuth,
      required String email,
      required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        throw e;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        throw e;
      }
    }
  }

  static Future<void> signUpNewUser(
      {required FirebaseAuth firebaseAuth,
      required LmsUser lmsUser,
      required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: lmsUser.email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        throw e;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        throw e;
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<bool> checkUserStatus(
      {required FirebaseAuth firebaseAuth}) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      Random random = new Random();
      return random.nextBool();
    } catch (e) {
      throw e;
    }
  }
}
