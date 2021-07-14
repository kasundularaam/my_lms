import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/my_enums.dart';
import 'package:my_lms/data/models/lms_user_model.dart';
import 'package:my_lms/logic/cubit/auth_cubit.dart';
import 'package:my_lms/logic/cubit/authscreen_nav_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/presentation/screens/widgets/my_button.dart';
import 'package:my_lms/presentation/screens/widgets/my_text_field.dart';

class SignUpPage extends StatefulWidget {
  final Function() goToLogin;
  final Function(LmsUser user, String password) signUp;
  const SignUpPage({
    Key? key,
    required this.goToLogin,
    required this.signUp,
  }) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email = "";
  String _password = "";
  String _name = "";
  List<String> _subjectList = ["1", "2", "3"];

  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).loadInitState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 7.h,
        ),
        Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 36.sp,
              color: MyColors.primaryDark,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 40.h,
        ),
        MyTextField(
          onChanged: (name) => _name = name,
          onSubmitted: (_) {
            _emailFocusNode.requestFocus();
          },
          textInputAction: TextInputAction.next,
          isPassword: false,
          hintText: "Name",
        ),
        SizedBox(
          height: 3.h,
        ),
        MyTextField(
          onChanged: (email) => _email = email,
          onSubmitted: (_) {
            _passwordFocusNode.requestFocus();
          },
          focusNode: _emailFocusNode,
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
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSucceed) {
              BlocProvider.of<AuthscreenNavCubit>(context)
                  .authNavigate(authNav: AuthNav.toSelectSubjectPage);
            }
          },
          builder: (context, state) {
            if (state is AuthInitial) {
              return buildInitState();
            } else if (state is AuthLoading) {
              return buildLoadingState();
            } else if (state is AuthFailed) {
              return buildFailedState(state.errorMsg);
            } else if (state is AuthInvalidValue) {
              return buildInvalidValueState(state.errorMsg);
            } else {
              return Center(child: Text("unhandled state excecuted!"));
            }
          },
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }

  Widget buildInitState() {
    return Column(
      children: [
        MyButton(
          btnText: "Sign Up",
          onPressed: () => widget.signUp(
            LmsUser(
                uid: "200129001050",
                name: _name,
                email: _email,
                subjectList: _subjectList),
            _password,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        goToLogIn(),
      ],
    );
  }

  Widget goToLogIn() {
    return GestureDetector(
      onTap: () => widget.goToLogin(),
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Text(
          "Log In",
          style: TextStyle(
              fontSize: 14.sp,
              color: MyColors.primaryDark,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget buildInvalidValueState(String errorMsg) {
    return Column(
      children: [
        ErrorMsgBox(errorMsg: errorMsg),
        SizedBox(
          height: 3.h,
        ),
        MyButton(
          btnText: "Sign Up",
          onPressed: () => widget.signUp(
            LmsUser(
                uid: "200129001050",
                name: _name,
                email: _email,
                subjectList: _subjectList),
            _password,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        goToLogIn(),
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
        onTap: () => BlocProvider.of<AuthCubit>(context).loadInitState(),
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
      goToLogIn(),
    ]);
  }
}
