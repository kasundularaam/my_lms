import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/my_enums.dart';
import 'package:my_lms/logic/cubit/auth_cubit.dart';
import 'package:my_lms/logic/cubit/authscreen_nav_cubit.dart';
import 'package:my_lms/presentation/router/app_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).checkUserStatus();
  }

  Future<void> goToHome() async {
    await Future.delayed(Duration(milliseconds: 300));
    Navigator.popAndPushNamed(context, AppRouter.home);
  }

  Future<void> navigateToLogin() async {
    await Future.delayed(Duration(milliseconds: 300));
    BlocProvider.of<AuthscreenNavCubit>(context)
        .authNavigate(authNav: AuthNav.toLogin);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthFailed) {
          return buildFailedState(state.errorMsg);
        } else if (state is AuthCheckUserStatus) {
          if (state.userStatus) {
            goToHome();
          } else {
            navigateToLogin();
          }
          return Container(
            child: Center(
              child: Text(state.statusMsg),
            ),
          );
        } else {
          return Text("unhandled state excecuted!");
        }
      },
    );
  }

  Widget buildFailedState(String errorMsg) {
    return Column(children: [
      Text(
        errorMsg,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      TextButton(
        onPressed: () => BlocProvider.of<AuthCubit>(context).checkUserStatus(),
        child: Text("Try Again"),
      ),
    ]);
  }
}
