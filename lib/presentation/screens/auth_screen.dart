import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/my_enums.dart';
import 'package:my_lms/logic/cubit/auth_cubit.dart';
import 'package:my_lms/logic/cubit/authscreen_nav_cubit.dart';
import 'package:my_lms/presentation/screens/pages/auth_page.dart';
import 'package:my_lms/presentation/screens/pages/login_page.dart';
import 'package:my_lms/presentation/screens/pages/signup_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthscreenNavCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        )
      ],
      child: Scaffold(
        body: BlocBuilder<AuthscreenNavCubit, AuthscreenNavState>(
          builder: (context, state) {
            if (state is AuthscreenNavInitial) {
              return AuthPage();
            } else if (state is AuthscreenNavigate) {
              if (state.authNav == AuthNav.toLogin) {
                return LoginPage(logIn: (email, password) {
                  BlocProvider.of<AuthCubit>(context)
                      .loginWithEmailAndpswd(email: email, password: password);
                }, goToSignUp: () {
                  BlocProvider.of<AuthscreenNavCubit>(context)
                      .authNavigate(authNav: AuthNav.toSignUp);
                });
              } else if (state.authNav == AuthNav.toSignUp) {
                return SignUpPage(
                  signUp: (user, password) {
                    BlocProvider.of<AuthCubit>(context)
                        .signUpNewUser(user: user, password: password);
                  },
                  goToLogin: () {
                    BlocProvider.of<AuthscreenNavCubit>(context)
                        .authNavigate(authNav: AuthNav.toLogin);
                  },
                );
              } else {
                return Text("nothing to show");
              }
            } else {
              return Text("nothing to show");
            }
          },
        ),
      ),
    );
  }
}
