import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void checkUserStatus() {
    try {
      bool userStatus = FirebaseRepo.checkUserStatus();
      String _statusMsg;
      if (userStatus) {
        _statusMsg = "Loading your data";
      } else {
        _statusMsg = "Please log in befor starting";
      }
      emit(AuthCheckUserStatus(userStatus: userStatus, statusMsg: _statusMsg));
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }
}
