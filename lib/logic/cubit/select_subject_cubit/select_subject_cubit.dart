import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/models/fire_subject_model.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';
import 'package:my_lms/data/value%20validator/auth_value_validator.dart';

part 'select_subject_state.dart';

class SelectSubjectCubit extends Cubit<SelectSubjectState> {
  SelectSubjectCubit() : super(SelectSubjectInitial());

  Future<void> updateSubjectList({required List<Subject> subjectList}) async {
    try {
      emit(
        SelectedSubjectLoading(
            loadingMsg: "adding selected subjects to the database..."),
      );
      await FirebaseRepo.addSubjects(
        subjectList:
            ValueValidator.validateSubjectList(subjectList: subjectList),
      );
      emit(
        SelectedSubjectSucceed(),
      );
    } catch (e) {
      emit(
        SelectedSubjectFailed(
          errorMsg: e.toString(),
        ),
      );
    }
  }
}
