import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_lms/data/models/lms_user_model.dart';

class FirebaseRepo {
  static Future<void> initializeApp() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      throw e;
    }
  }

  static Future<LmsUser> loginWithEmailAndpswd(
      {required FirebaseAuth firebaseAuth,
      required String email,
      required String password}) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      return LmsUser(
        uid: "200129001050",
        name: "Kasun Dulara",
        email: "$email",
        streamId: "engineeringtec",
      );
    } catch (e) {
      throw e;
    }
  }

  static Future<LmsUser> signUpNewUser(
      {required FirebaseAuth firebaseAuth,
      required LmsUser user,
      required String password}) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      return LmsUser(
        uid: "200129001050",
        name: "${user.name}",
        email: "${user.email}",
        streamId: "${user.streamId}",
      );
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
