import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/models/fire_user_model.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/data/repositories/firebase_repo/firebase_auth_repo.dart';
import 'package:my_lms/data/repositories/firebase_repo/firebse_subject_repo.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  Future<void> loadProfileSettings() async {
    try {
      emit(SettingLoading());
      FireUser fireUser = await FirebaseAuthRepo.getUserDetails();
      List<Subject> subjects = await FirebaseSubjectRepo.getSubjects();
      emit(SettingLoaded(fireUser: fireUser, subjects: subjects));
    } catch (e) {
      emit(SettingFailed(errorMsg: e.toString()));
    }
  }
}
