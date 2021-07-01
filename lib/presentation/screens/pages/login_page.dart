import 'package:flutter/material.dart';

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
