import 'package:flutter/material.dart';
import 'package:my_lms/data/models/user_model.dart';

import 'package:my_lms/presentation/screens/widgets/my_button.dart';
import 'package:my_lms/presentation/screens/widgets/my_text_field.dart';

class SignUpPage extends StatefulWidget {
  final Function() goToLogin;
  final Function(User user, String password) signUp;
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
  String _streamId = "engineeringtec";

  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
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
          "SignUp",
          style: TextStyle(
            fontSize: 38.0,
          ),
        ),
        SizedBox(
          height: 200,
        ),
        MyTextField(
          onChanged: (name) => _name = name,
          onSubmitted: (_) {
            _emailFocusNode.requestFocus();
          },
          textInputAction: TextInputAction.next,
          isPassword: false,
          hintText: "Name",
          fontSize: 20.0,
        ),
        SizedBox(
          height: 20,
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
          btnText: "Sign Up",
          onPressed: () => widget.signUp(
            User(
                uid: "200129001050",
                name: _name,
                email: _email,
                streamId: "engineeringtec"),
            _password,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => widget.goToLogin(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("LogIn"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
