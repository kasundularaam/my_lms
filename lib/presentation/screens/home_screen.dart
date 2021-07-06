import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/logic/cubit/auth_cubit.dart';
import 'package:my_lms/presentation/router/app_router.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).loadInitState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSucceed) {
            Navigator.popAndPushNamed(context, AppRouter.authScreen);
          }
        },
        builder: (context, state) {
          if (state is AuthInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).logOutUser();
                    },
                    child: Text("Log Out"),
                  ),
                ],
              ),
            );
          } else if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthSucceed) {
            return Center(
              child: Text("Signed out"),
            );
          } else {
            return Text("unhandled state excecuted!");
          }
        },
      ),
    );
  }
}
