import 'package:cloud_firestore/cloud_firestore.dart';
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
      required FirebaseFirestore firestore,
      required LmsUser lmsUser,
      required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: lmsUser.email,
        password: password,
      );
      await setUser(
          firebaseAuth: firebaseAuth, firestore: firestore, lmsUser: lmsUser);
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

  static Future<void> setUser({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    required LmsUser lmsUser,
  }) async {
    User? currenUser = firebaseAuth.currentUser;
    if (currenUser != null) {
      try {
        CollectionReference users = firestore.collection("users");
        await users.doc(currenUser.uid).set({
          "uid": currenUser.uid,
          "name": lmsUser.name,
          "email": currenUser.email,
          "subjectList": []
        });
      } catch (e) {
        throw e;
      }
    } else {
      throw "canot set database. user does not exist";
    }
  }

  static Future<void> updateSelectedSubjects({
    required List<String> subjectList,
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  }) async {
    User? currenUser = firebaseAuth.currentUser;
    if (currenUser != null) {
      try {
        CollectionReference users = firestore.collection("users");
        await users.doc(currenUser.uid).update({"subjectList": subjectList});
      } catch (e) {
        throw e;
      }
    } else {
      throw "canot set database. user does not exist";
    }
  }
}
