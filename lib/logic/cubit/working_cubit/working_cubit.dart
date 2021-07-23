import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/core/constants/shared_prefs_keys.dart';
import 'package:my_lms/core/screen_arguments/end_tab_args.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'working_state.dart';

class WorkingCubit extends Cubit<WorkingState> {
  WorkingCubit() : super(WorkingInitial());

  Future<void> enteringWorkingScreen({required String contentId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isOnWorking = prefs.getBool(SharedPrefsKeys.isOnWorkingKey);
    if (isOnWorking != null) {
      if (isOnWorking) {
        int startTimeStampSp =
            prefs.getInt(SharedPrefsKeys.startTimeStampKey) ?? 0;
        String prefContentId =
            prefs.getString(SharedPrefsKeys.contentIdKey) ?? "";
        String prefContentName =
            prefs.getString(SharedPrefsKeys.contentNameKey) ?? "";
        if (contentId == prefContentId) {
          emit(WorkingInitial());
        } else {
          emit(WorkingOnNow(workingContentName: prefContentName));
        }
      } else {
        emit(WorkingInitial());
      }
    } else {
      emit(WorkingInitial());
    }
  }
}
