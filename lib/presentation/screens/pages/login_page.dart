import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/logic/cubit/auth_cubit.dart';
import 'package:my_lms/presentation/router/app_router.dart';

import 'package:my_lms/presentation/screens/widgets/my_button.dart';
import 'package:my_lms/presentation/screens/widgets/my_text_field.dart';

class LoginPage extends StatefulWidget {
  final Function() goToSignUp;
  final Function(String email, String password) logIn;
  const LoginPage({
    Key? key,
    required this.goToSignUp,
    required this.logIn,
  }) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";

  FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).loadInitState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Log In",
          style: TextStyle(
            fontSize: 38.0,
          ),
        ),
        SizedBox(
          height: 300,
        ),
        MyTextField(
          onChanged: (email) => _email = email,
          onSubmitted: (_) {
            _passwordFocusNode.requestFocus();
          },
          textInputAction: TextInputAction.next,
          isPassword: false,
          hintText: "Email",
          fontSize: 20.0,
        ),
        SizedBox(
          height: 20,
        ),
        MyTextField(
          onChanged: (password) => _password = password,
          onSubmitted: (_) {},
          textInputAction: TextInputAction.next,
          isPassword: false,
          focusNode: _passwordFocusNode,
          hintText: "Password",
          fontSize: 20.0,
        ),
        SizedBox(
          height: 20,
        ),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSucceed) {
              Navigator.popAndPushNamed(context, AppRouter.home);
            }
          },
          builder: (context, state) {
            if (state is AuthInitial) {
              return buildInitialState();
            } else if (state is AuthLoading) {
              return buildLoadingState();
            } else if (state is AuthFailed) {
              return buildFailedState(state.errorMsg);
            } else if (state is AuthInvalidValue) {
              return buildInvalidValueState(state.errorMsg);
            } else {
              return Text("nothing to show");
            }
          },
        ),
      ],
    );
  }

  Widget buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailedState(String errorMsg) {
    return Column(children: [
      Text(
        errorMsg,
      ),
      TextButton(
        onPressed: () => BlocProvider.of<AuthCubit>(context).loadInitState(),
        child: Text("Try Again"),
      ),
      SizedBox(
        height: 20,
      ),
      GestureDetector(
        onTap: () => widget.goToSignUp(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("SignUp"),
        ),
      ),
    ]);
  }

  Widget buildInvalidValueState(String errorMsg) {
    return Column(
      children: [
        Text(errorMsg),
        SizedBox(
          height: 20,
        ),
        MyButton(
          btnText: "Log In",
          onPressed: () => widget.logIn(_email, _password),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => widget.goToSignUp(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("SignUp"),
          ),
        ),
      ],
    );
  }

  Widget buildInitialState() {
    return Column(
      children: [
        MyButton(
          btnText: "Log In",
          onPressed: () => widget.logIn(_email, _password),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => widget.goToSignUp(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("SignUp"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
