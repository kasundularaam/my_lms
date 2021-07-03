import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'package:my_lms/data/models/lms_user_model.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth firebaseAuth;
  AuthCubit({
    required this.firebaseAuth,
  }) : super(AuthInitial());

  Future<void> initializeApp() async {
    try {
      emit(AuthLoading(loadingMsg: "App initializing..."));
      await FirebaseRepo.initializeApp();
      emit(AuthAppInitializeSucceed(succeedMsg: "App initialize succeed"));
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }

  Future<void> loginWithEmailAndpswd(
      {required String email, required String password}) async {
    try {
      emit(AuthLoading(loadingMsg: "Logging to your account..."));
      LmsUser lmsUer = await FirebaseRepo.loginWithEmailAndpswd(
          firebaseAuth: firebaseAuth, email: email, password: password);
      emit(AuthSucceed(lmsUser: lmsUer));
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }

  Future<void> signUpNewUser(
      {required LmsUser lmsUser, required String password}) async {
    try {
      emit(AuthLoading(loadingMsg: "Creating new account..."));
      LmsUser newUser = await FirebaseRepo.signUpNewUser(
          firebaseAuth: firebaseAuth, user: lmsUser, password: password);
      emit(AuthSucceed(lmsUser: newUser));
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
