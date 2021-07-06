import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/core/my_enums.dart';

part 'authscreen_nav_state.dart';

class AuthscreenNavCubit extends Cubit<AuthscreenNavState> {
  AuthscreenNavCubit() : super(AuthscreenNavInitial());

  void authNavigate({required AuthNav authNav}) {
    if (authNav == AuthNav.toLogin) {
      print("auth nav login");
    } else if (authNav == AuthNav.toSignUp) {
      print("auth nav login");
    } else if (authNav == AuthNav.toAuthPage) {
      print("auth nav login");
    } else {
      print("auth nav else");
    }
    print(authNav.toString());
    emit(AuthscreenNavigate(authNav: authNav));
  }
}
