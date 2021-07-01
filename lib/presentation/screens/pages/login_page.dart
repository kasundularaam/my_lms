import 'package:flutter/material.dart';
import 'package:my_lms/presentation/screens/widgets/my_button.dart';
import 'package:my_lms/presentation/screens/widgets/my_text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _loginEmail = "";
  String _loginPassword = "";

  FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 300,
          ),
          MyTextField(
            onChanged: (email) => _loginEmail = email,
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
            onChanged: (password) => _loginPassword = password,
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
          MyButton(btnText: "Log In", onPressed: () {}),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("SignUp"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
