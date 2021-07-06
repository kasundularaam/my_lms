import 'package:firebase_auth/firebase_auth.dart';
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
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
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
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
    } catch (e) {
      throw e;
    }
  }

  static bool checkUserStatus({required FirebaseAuth firebaseAuth}) {
    try {
      User? currenUser = firebaseAuth.currentUser;
      if (currenUser != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<void> logOutUser({required FirebaseAuth firebaseAuth}) async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw e;
    }
  }
}
