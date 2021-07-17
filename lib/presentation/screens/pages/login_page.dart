import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/my_enums.dart';
import 'package:my_lms/logic/cubit/auth_nav_cubit/authscreen_nav_cubit.dart';
import 'package:my_lms/logic/cubit/login_cubit/login_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/presentation/screens/widgets/my_button.dart';
import 'package:my_lms/presentation/screens/widgets/my_text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";

  FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 5.h,
        ),
        Text(
          "Log In",
          style: TextStyle(
              fontSize: 36.sp,
              color: MyColors.primaryDark,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 40.h,
        ),
        MyTextField(
          onChanged: (email) => _email = email,
          onSubmitted: (_) {
            _passwordFocusNode.requestFocus();
          },
          textInputAction: TextInputAction.next,
          isPassword: false,
          hintText: "Email",
        ),
        SizedBox(
          height: 3.h,
        ),
        MyTextField(
          onChanged: (password) => _password = password,
          onSubmitted: (_) {},
          textInputAction: TextInputAction.next,
          isPassword: true,
          focusNode: _passwordFocusNode,
          hintText: "Password",
        ),
        SizedBox(
          height: 3.h,
        ),
        BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSucceed) {
              BlocProvider.of<AuthscreenNavCubit>(context)
                  .authNavigate(authNav: AuthNav.toAuthPage);
            }
          },
          builder: (context, state) {
            if (state is LoginInitial) {
              return buildInitialState();
            } else if (state is LoginLoading) {
              return buildLoadingState();
            } else if (state is LoginFailed) {
              return buildFailedState(state.errorMsg);
            } else if (state is LoginWithInvalidValue) {
              return buildInvalidValueState(state.errorMsg);
            } else {
              return Text("unhandled state excecuted!");
            }
          },
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }

  Widget buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.primaryDark,
      ),
    );
  }

  Widget buildFailedState(String errorMsg) {
    return Column(children: [
      ErrorMsgBox(errorMsg: errorMsg),
      SizedBox(
        height: 3.h,
      ),
      GestureDetector(
        onTap: () => BlocProvider.of<LoginCubit>(context).emit(LoginInitial()),
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Text(
            "Try again",
            style: TextStyle(
                fontSize: 14.sp,
                color: MyColors.primaryDark,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
      SizedBox(
        height: 5.h,
      ),
      goToSignUp(),
    ]);
  }

  Widget buildInvalidValueState(String errorMsg) {
    return Column(
      children: [
        ErrorMsgBox(errorMsg: errorMsg),
        SizedBox(
          height: 3.h,
        ),
        MyButton(
          btnText: "Log In",
          onPressed: () =>
              BlocProvider.of<LoginCubit>(context).loginWithEmailAndpswd(
            email: _email,
            password: _password,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        goToSignUp(),
      ],
    );
  }

  Widget buildInitialState() {
    return Column(
      children: [
        MyButton(
          btnText: "Log In",
          onPressed: () =>
              BlocProvider.of<LoginCubit>(context).loginWithEmailAndpswd(
            email: _email,
            password: _password,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        goToSignUp(),
      ],
    );
  }

  Widget goToSignUp() {
    return GestureDetector(
      onTap: () => BlocProvider.of<AuthscreenNavCubit>(context).authNavigate(
        authNav: AuthNav.toSignUp,
      ),
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 14.sp,
              color: MyColors.primaryDark,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
