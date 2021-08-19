import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/data/repositories/firebase_repo/firebase_auth_repo.dart';

class FirebaseSubjectRepo {
  static Future<void> addSubjects({
    required List<Subject> subjectList,
  }) async {
    try {
      CollectionReference subjects = FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuthRepo.currentUid())
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

  static Future<List<Subject>> getSubjects() async {
    try {
      List<Subject> subjectList = [];
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuthRepo.currentUid())
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
