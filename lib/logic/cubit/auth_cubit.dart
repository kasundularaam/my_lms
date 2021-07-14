import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'package:my_lms/data/models/lms_user_model.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';
import 'package:my_lms/data/value%20validator/auth_value_validator.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  AuthCubit({
    required this.firebaseAuth,
    required this.firestore,
  }) : super(AuthInitial());

  Future<void> loginWithEmailAndpswd(
      {required String email, required String password}) async {
    String emailFeedback = ValueValidator.validateEmail(email: email);
    String passwordFeedback =
        ValueValidator.validatePassword(password: password);
    if (emailFeedback == ValueValidator.validEmail) {
      if (passwordFeedback == ValueValidator.validPassword) {
        try {
          emit(AuthLoading(loadingMsg: "Logging to your account..."));
          await FirebaseRepo.loginWithEmailAndpswd(
              firebaseAuth: firebaseAuth, email: email, password: password);
          emit(AuthSucceed());
        } catch (e) {
          emit(AuthFailed(errorMsg: e.toString()));
        }
      } else {
        emit(AuthInvalidValue(errorMsg: passwordFeedback));
      }
    } else {
      emit(AuthInvalidValue(errorMsg: emailFeedback));
    }
  }

  Future<void> signUpNewUser(
      {required LmsUser lmsUser, required String password}) async {
    String emailFeedback = ValueValidator.validateEmail(email: lmsUser.email);
    String passwordFeedback =
        ValueValidator.validatePassword(password: password);
    String nameFeedback = ValueValidator.validateName(name: lmsUser.name);
    if (nameFeedback == ValueValidator.validName) {
      if (emailFeedback == ValueValidator.validEmail) {
        if (passwordFeedback == ValueValidator.validPassword) {
          try {
            emit(AuthLoading(loadingMsg: "Creating new account..."));
            await FirebaseRepo.signUpNewUser(
                firebaseAuth: firebaseAuth,
                firestore: firestore,
                lmsUser: lmsUser,
                password: password);
            emit(AuthSucceed());
          } catch (e) {
            emit(AuthFailed(errorMsg: e.toString()));
          }
        } else {
          emit(AuthInvalidValue(errorMsg: passwordFeedback));
        }
      } else {
        emit(AuthInvalidValue(errorMsg: emailFeedback));
      }
    } else {
      emit(AuthInvalidValue(errorMsg: nameFeedback));
    }
  }

  void checkUserStatus() {
    try {
      bool userStatus = FirebaseRepo.checkUserStatus(
        firebaseAuth: firebaseAuth,
      );
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

  void loadInitState() {
    emit(AuthInitial());
  }

  Future<void> logOutUser() async {
    try {
      emit(AuthLoading(loadingMsg: "Logging out from your account..."));
      await FirebaseRepo.logOutUser(firebaseAuth: firebaseAuth);
      emit(AuthSucceed());
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }

  Future<void> updateSubjectList({required List<String> subjectList}) async {
    try {
      emit(
        AuthLoading(loadingMsg: "adding selected subjects to the database..."),
      );
      await FirebaseRepo.updateSelectedSubjects(
        subjectList:
            ValueValidator.validateSubjectList(subjectList: subjectList),
        firebaseAuth: firebaseAuth,
        firestore: firestore,
      );
      emit(
        AuthSucceed(),
      );
    } catch (e) {
      emit(
        AuthFailed(
          errorMsg: e.toString(),
        ),
      );
    }
  }
}
