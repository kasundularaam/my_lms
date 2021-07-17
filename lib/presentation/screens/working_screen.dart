import 'package:flutter/material.dart';

class WorkingScreen extends StatefulWidget {
  const WorkingScreen({Key? key}) : super(key: key);

  @override
  _WorkingScreenState createState() => _WorkingScreenState();
}

class _WorkingScreenState extends State<WorkingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Working Screen"),
      ),
    );
  }
}
