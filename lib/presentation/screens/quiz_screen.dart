import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final String moduleId;
  final String moduleName;
  const QuizScreen({
    Key? key,
    required this.moduleId,
    required this.moduleName,
  }) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Quiz Scrren"),
      ),
    );
  }
}
