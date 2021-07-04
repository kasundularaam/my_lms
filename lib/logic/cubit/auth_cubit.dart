import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'package:my_lms/data/models/lms_user_model.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';
import 'package:my_lms/data/value%20validator/value_validator.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth firebaseAuth;
  AuthCubit({
    required this.firebaseAuth,
  }) : super(AuthInitial());

  Future<void> loginWithEmailAndpswd(
      {required String email, required String password}) async {
    try {
      bool validEmail = ValueValidator.validateEmail(email: email);
      bool validPassword = ValueValidator.validatePassword(password: password);
      if (validEmail) {
        if (validPassword) {
          emit(AuthLoading(loadingMsg: "Logging to your account..."));
          await FirebaseRepo.loginWithEmailAndpswd(
              firebaseAuth: firebaseAuth, email: email, password: password);
          emit(AuthSucceed());
        } else {
          emit(AuthInvalidValue(
              errorMsg: "Password must contains atleast 6 characters"));
        }
      } else {
        emit(AuthInvalidValue(
            errorMsg:
                "email you entered is not in valid format please check again"));
      }
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }

  Future<void> signUpNewUser(
      {required LmsUser lmsUser, required String password}) async {
    try {
      bool validEmail = ValueValidator.validateEmail(email: lmsUser.email);
      bool validPassword = ValueValidator.validatePassword(password: password);
      if (validEmail) {
        if (validPassword) {
          emit(AuthLoading(loadingMsg: "Creating new account..."));
          await FirebaseRepo.signUpNewUser(
              firebaseAuth: firebaseAuth, lmsUser: lmsUser, password: password);
          emit(AuthSucceed());
        } else {
          emit(AuthInvalidValue(
              errorMsg: "Password must contains atleast 6 characters"));
        }
      } else {
        emit(AuthInvalidValue(
            errorMsg:
                "email you entered is not in valid format please check again"));
      }
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }

  Future<void> checkUserStatus() async {
    try {
      emit(AuthLoading(loadingMsg: "Checking authentication..."));
      bool userStatus = await FirebaseRepo.checkUserStatus(
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
}
