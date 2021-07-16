import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';
import 'package:my_lms/data/value%20validator/auth_value_validator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginWithEmailAndpswd(
      {required String email, required String password}) async {
    String emailFeedback = ValueValidator.validateEmail(email: email);
    String passwordFeedback =
        ValueValidator.validatePassword(password: password);
    if (emailFeedback == ValueValidator.validEmail) {
      if (passwordFeedback == ValueValidator.validPassword) {
        try {
          emit(LoginLoading(loadingMsg: "Logging to your account..."));
          await FirebaseRepo.loginWithEmailAndpswd(
              email: email, password: password);
          emit(LoginSucceed());
        } catch (e) {
          emit(LoginFailed(errorMsg: e.toString()));
        }
      } else {
        emit(LoginWithInvalidValue(errorMsg: passwordFeedback));
      }
    } else {
      emit(LoginWithInvalidValue(errorMsg: emailFeedback));
    }
  }
}
