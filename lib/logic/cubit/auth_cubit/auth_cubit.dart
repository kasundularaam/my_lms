import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/http/http_client.dart';
import 'package:my_lms/data/models/fire_subject_model.dart';

import 'package:my_lms/data/models/lms_user_model.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';
import 'package:my_lms/data/value%20validator/auth_value_validator.dart';

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
