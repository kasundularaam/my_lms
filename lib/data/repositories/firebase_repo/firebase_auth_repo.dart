import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_lms/data/models/fire_user_model.dart';

class FirebaseAuthRepo {
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
            lmsUser: FireUser(uid: currentUser.uid, name: name, email: email));
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
    required FireUser lmsUser,
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

  static String currentUid() {
    try {
      User? currenUser = FirebaseAuth.instance.currentUser;
      if (currenUser != null) {
        return currenUser.uid;
      } else {
        throw "user not available";
      }
    } catch (e) {
      throw e;
    }
  }

  static String currentEmail() {
    try {
      User? currenUser = FirebaseAuth.instance.currentUser;
      if (currenUser != null) {
        return currenUser.email!;
      } else {
        throw "user not available";
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<FireUser> getUserDetails() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuthRepo.currentUid())
          .get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>;
      return FireUser(
        email: data['email'],
        name: data['name'],
        uid: data['uid'],
      );
    } catch (e) {
      throw e;
    }
  }

  static Future<void> updateUserName({required String newName}) async {
    try {
      if (newName.isNotEmpty) {
        CollectionReference reference =
            FirebaseFirestore.instance.collection("users");
        await reference.doc(currentUid()).update({'name': newName});
      } else {
        throw "Name is empty!";
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<void> changePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      if (currentPassword.isNotEmpty && newPassword.isNotEmpty) {
        await loginWithEmailAndpswd(
            email: currentEmail(), password: currentPassword);
        await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      } else {
        throw "Some fields are empty!";
      }
    } catch (e) {
      throw e;
    }
  }
}
