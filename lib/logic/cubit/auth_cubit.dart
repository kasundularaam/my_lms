import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/models/user_model.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginWithEmailAndpswd(
      {required String email, required String password}) async {
    try {
      emit(AuthLoading());
      User user = await FirebaseRepo.loginWithEmailAndpswd(
          email: email, password: password);
      emit(AuthSucceed(user: user));
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }

  Future<void> signUpNewUser(
      {required User user, required String password}) async {
    try {
      emit(AuthLoading());
      User newUser = await FirebaseRepo.signUpNewUser(user: user);
      emit(AuthSucceed(user: newUser));
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }

  Future<void> checkUserStatus() async {
    try {
      emit(AuthLoading());
      bool userStatus = await FirebaseRepo.checkUserStatus();
      emit(AuthCheckUserStatus(userStatus: userStatus));
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }

  void loadInitState() {
    emit(AuthInitial());
  }
}
