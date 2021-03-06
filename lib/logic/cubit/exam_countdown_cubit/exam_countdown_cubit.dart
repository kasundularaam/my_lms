import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/core/constants/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'exam_countdown_state.dart';

class ExamCountdownCubit extends Cubit<ExamCountdownState> {
  ExamCountdownCubit() : super(ExamCountdownInitial());

  Future<void> loadCountDown() async {
    emit(ExamCountdownLoading());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int examTimeStamp =
        preferences.getInt(SharedPrefsKeys.examTimeStampKey) ?? 0;
    if (examTimeStamp == 0) {
      emit(ExamCountdownEdit(available: false));
    } else {
      emit(ExamCountdownRunning(examTimeStamp: examTimeStamp));
    }
  }

  Future<void> setExamDateTime(
      {required DateTime dateTime, required TimeOfDay timeOfDay}) async {
    emit(ExamCountdownLoading());
    int exameDateTimeStmp = DateTime(dateTime.year, dateTime.month,
            dateTime.day, timeOfDay.hour, timeOfDay.minute)
        .millisecondsSinceEpoch;
    print("EXAM TIME STMPFF: $exameDateTimeStmp");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(SharedPrefsKeys.examTimeStampKey, exameDateTimeStmp);
    await loadCountDown();
  }
}
