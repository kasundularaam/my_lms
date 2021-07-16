import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_lms/data/models/fire_subject_model.dart';
import 'package:my_lms/data/models/lms_user_model.dart';

class FirebaseRepo {
  static Future<void> loginWithEmailAndpswd(
      {required String email, required String password}) async {
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
      {required String name,
      required String email,
      required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await addUserToFireStore(
            lmsUser: LmsUser(uid: currentUser.uid, name: name, email: email));
      } else {
        throw "canot add user to database. user does not exist";
      }
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

  static bool checkUserStatus() {
    try {
      User? currenUser = FirebaseAuth.instance.currentUser;
      if (currenUser != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<void> logOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addUserToFireStore({
    required LmsUser lmsUser,
  }) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection("users");
      await users.doc(lmsUser.uid).set({
        "uid": lmsUser.uid,
        "name": lmsUser.name,
        "email": lmsUser.email,
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addSubjects({
    required List<FireSubject> subjectList,
  }) async {
    User? currenUser = FirebaseAuth.instance.currentUser;
    if (currenUser != null) {
      try {
        CollectionReference subjects = FirebaseFirestore.instance
            .collection("users")
            .doc(currenUser.uid)
            .collection("subjects");
        subjectList.forEach((subject) async {
          await subjects.doc(subject.id).set({
            "id": subject.id,
            "name": subject.name,
            "isCompleted": subject.isCompleted
          });
        });
      } catch (e) {
        throw e;
      }
    } else {
      throw "canot update database. user does not exist";
    }
  }
}
