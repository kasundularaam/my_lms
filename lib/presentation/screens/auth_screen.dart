import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/my_enums.dart';
import 'package:my_lms/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:my_lms/logic/cubit/auth_nav_cubit/authscreen_nav_cubit.dart';
import 'package:my_lms/logic/cubit/login_cubit/login_cubit.dart';
import 'package:my_lms/logic/cubit/select_sub_list_cubit/select_sub_list_cubit.dart';
import 'package:my_lms/logic/cubit/select_subject_cubit/select_subject_cubit.dart';
import 'package:my_lms/logic/cubit/signup_cubit/signup_cubit.dart';
import 'package:my_lms/presentation/screens/pages/auth_page.dart';
import 'package:my_lms/presentation/screens/pages/login_page.dart';
import 'package:my_lms/presentation/screens/pages/select_subject_page.dart';
import 'package:my_lms/presentation/screens/pages/signup_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthscreenNavCubit(),
      child: Scaffold(
        backgroundColor: MyColors.offWhite,
        body: BlocBuilder<AuthscreenNavCubit, AuthscreenNavState>(
          builder: (context, state) {
            if (state is AuthscreenNavInitial) {
              return BlocProvider(
                create: (context) => AuthCubit(),
                child: AuthPage(),
              );
            } else if (state is AuthscreenNavigate) {
              if (state.authNav == AuthNav.toLogin) {
                return BlocProvider(
                  create: (context) => LoginCubit(),
                  child: LoginPage(),
                );
              } else if (state.authNav == AuthNav.toSignUp) {
                return BlocProvider(
                  create: (context) => SignupCubit(),
                  child: SignUpPage(),
                );
              } else if (state.authNav == AuthNav.toAuthPage) {
                return BlocProvider(
                  create: (context) => AuthCubit(),
                  child: AuthPage(),
                );
              } else if (state.authNav == AuthNav.toSelectSubjectPage) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<SelectSubListCubit>(
                      create: (context) => SelectSubListCubit(),
                    ),
                    BlocProvider<SelectSubjectCubit>(
                      create: (context) => SelectSubjectCubit(),
                    )
                  ],
                  child: SelectSubjectPage(),
                );
              } else {
                return Center(child: Text("sorry no page available!"));
              }
            } else {
              return Center(child: Text("unhandled state excecuted!"));
            }
          },
        ),
      ),
    );
  }
}
