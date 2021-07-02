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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthCheckUserStatus) {
          if (state.userStatus) {
            Navigator.popAndPushNamed(context, AppRouter.home);
          } else {
            BlocProvider.of<AuthscreenNavCubit>(context)
                .authNavigate(authNav: AuthNav.toLogin);
          }
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Container(
            child: Center(
              child: Text("authenticating..."),
            ),
          );
        } else if (state is AuthFailed) {
          return buildFailedState();
        } else {
          return Text("nothing to show");
        }
      },
    );
  }

  Widget buildFailedState() {
    return Column(children: [
      Text(
        "Authentication Failed",
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
