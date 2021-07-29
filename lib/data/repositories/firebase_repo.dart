import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_lms/core/screen_arguments/end_tab_args.dart';
import 'package:my_lms/data/models/fire_content.dart';
import 'package:my_lms/data/models/fire_module_model.dart';
import 'package:my_lms/data/models/lms_user_model.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/data/repositories/repository.dart';

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
    required List<Subject> subjectList,
  }) async {
    try {
      CollectionReference subjects = FirebaseFirestore.instance
          .collection("users")
          .doc(currentUid())
          .collection("subjects");
      subjectList.forEach((subject) async {
        await subjects.doc(subject.id).set({
          "id": subject.id,
          "name": subject.name,
        });
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addWorkDetails(
      {required bool isCompleted, required EndTabArgs endTabArgs}) async {
    try {
      CollectionReference reference = FirebaseFirestore.instance
          .collection("users")
          .doc(currentUid())
          .collection("subjects")
          .doc(endTabArgs.contentScreenArgs.subjectId)
          .collection("contents");
      reference.add({
        'contentId': endTabArgs.contentScreenArgs.contentId,
        'contentName': endTabArgs.contentScreenArgs.contentName,
        'subjectName': endTabArgs.contentScreenArgs.subjectName,
        'subjectId': endTabArgs.contentScreenArgs.subjectId,
        'moduleName': endTabArgs.contentScreenArgs.moduleName,
        'moduleId': endTabArgs.contentScreenArgs.moduleId,
        'startTimestamp': endTabArgs.startTimestamp,
        'endTimestamp': endTabArgs.endTimestamp,
        'counter': endTabArgs.counter,
        'isCompleted': isCompleted,
      });
      int contentCountOfMod = await Repository.getContentCountByModId(
          moduleId: endTabArgs.contentScreenArgs.moduleId);
      int fireContentCountOfMod = await getCompltedContentCountForMod(
          subjectId: endTabArgs.contentScreenArgs.subjectId,
          moduleId: endTabArgs.contentScreenArgs.moduleId);
      if (fireContentCountOfMod == contentCountOfMod) {
        addFireModule(
            subjectId: endTabArgs.contentScreenArgs.subjectId,
            moduleId: endTabArgs.contentScreenArgs.moduleId,
            moduleName: endTabArgs.contentScreenArgs.moduleName);
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addFireModule(
      {required String subjectId,
      required String moduleId,
      required String moduleName}) async {
    try {
      CollectionReference reference = FirebaseFirestore.instance
          .collection("users")
          .doc(currentUid())
          .collection("subjects")
          .doc(subjectId)
          .collection("modules");
      reference.doc(moduleId).set({
        'id': moduleId,
        'name': moduleName,
        'isCompleted': true,
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireModule>> getFiremodules(
      {required String subjectId}) async {
    try {
      List<FireModule> moduleList = [];
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUid())
          .collection("subjects")
          .doc(subjectId)
          .collection("modules")
          .get();
      snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        moduleList.add(FireModule(
            id: data['id'],
            name: data['name'],
            isCompleted: data['isCompleted']));
      }).toList();
      return moduleList;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getFireModuleCount({required String subjectId}) async {
    try {
      List<FireModule> moduleList = await getFiremodules(subjectId: subjectId);
      return moduleList.length;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireContent>> getFireContents(
      {required String subjectId}) async {
    try {
      List<FireContent> fireContentList = [];
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUid())
          .collection("subjects")
          .doc(subjectId)
          .collection("contents")
          .get();
      snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        fireContentList.add(FireContent(
            startTimestamp: data['startTimestamp'],
            endTimestamp: data['endTimestamp'],
            counter: data['counter'],
            contentId: data['contentId'],
            contentName: data['contentName'],
            subjectName: data['subjectName'],
            subjectId: data['subjectId'],
            moduleName: data['moduleName'],
            moduleId: data['moduleId'],
            isCompleted: data['isCompleted']));
      }).toList();
      return fireContentList;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireContent>> getCompletedContents(
      {required String subjectId}) async {
    try {
      List<FireContent> filteredList = [];
      List<FireContent> fireContentList =
          await getFireContents(subjectId: subjectId);
      fireContentList.forEach((fireContent) {
        if (fireContent.isCompleted) {
          filteredList.add(fireContent);
        }
      });
      return filteredList;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireContent>> getCleanCompletedContentList(
      {required String subjectId}) async {
    try {
      List<FireContent> cleanedList = [];
      List<String> idList = [];
      List<FireContent> filteredList =
          await getCompletedContents(subjectId: subjectId);
      filteredList.forEach((fireContent) {
        if (!idList.contains(fireContent.contentId)) {
          print(fireContent.contentName);
          idList.add(fireContent.contentId);
          cleanedList.add(fireContent);
        }
      });
      return cleanedList;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getCompltedContentCount(
      {required String subjectId}) async {
    try {
      List<FireContent> cleanedList =
          await getCleanCompletedContentList(subjectId: subjectId);
      return cleanedList.length;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<FireContent>> fireContentListForMod(
      {required String subjectId, required String moduleId}) async {
    try {
      List<FireContent> filteredList = [];
      List<FireContent> cleanedList =
          await getCleanCompletedContentList(subjectId: subjectId);
      cleanedList.forEach((fireContent) {
        if (fireContent.moduleId == moduleId) {
          filteredList.add(fireContent);
        }
      });
      return filteredList;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getCompltedContentCountForMod(
      {required String subjectId, required String moduleId}) async {
    try {
      List<FireContent> filteredList =
          await fireContentListForMod(subjectId: subjectId, moduleId: moduleId);
      return filteredList.length;
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

  static Future<List<Subject>> getSubjectList() async {
    try {
      List<Subject> subjectList = [];
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUid())
          .collection("subjects")
          .get();
      snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        subjectList.add(Subject(id: data["id"], name: data["name"]));
      }).toList();
      return subjectList;
    } catch (e) {
      throw e;
    }
  }
}
