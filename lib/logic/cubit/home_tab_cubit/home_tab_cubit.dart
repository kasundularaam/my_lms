import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'home_tab_state.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  HomeTabCubit() : super(HomeTabInitial());

  Future<void> loadSubjects() async {
    try {
      emit(HomeTabLoading());
      List<Subject> subjectList = await FirebaseRepo.getSubjects();
      emit(HomeTabLoaded(subjectList: subjectList));
    } catch (e) {
      emit(HomeTabFailed(errorMsg: e.toString()));
    }
  }
}
