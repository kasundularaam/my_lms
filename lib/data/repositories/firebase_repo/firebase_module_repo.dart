import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_lms/data/models/fire_module_model.dart';
import 'package:my_lms/data/repositories/firebase_repo/firebase_auth_repo.dart';

class FirebaseModuleRepo {
  static Future<void> addFireModule(
      {required String subjectId,
      required String moduleId,
      required String moduleName}) async {
    try {
      CollectionReference reference = FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuthRepo.currentUid())
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
          .doc(FirebaseAuthRepo.currentUid())
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
}
