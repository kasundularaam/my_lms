import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/core/my_enums.dart';

part 'authscreen_nav_state.dart';

class AuthscreenNavCubit extends Cubit<AuthscreenNavState> {
  AuthscreenNavCubit() : super(AuthscreenNavInitial());

  void authNavigate({required AuthNav authNav}) {
    emit(AuthscreenNavigate(authNav: authNav));
  }
}
