import 'package:flutter/material.dart';

class ContentListScreen extends StatefulWidget {
  final String moduleId;
  final String moduleName;
  const ContentListScreen({
    Key? key,
    required this.moduleId,
    required this.moduleName,
  }) : super(key: key);

  @override
  _ContentListScreenState createState() => _ContentListScreenState();
}

class _ContentListScreenState extends State<ContentListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("contentList"),
      ),
    );
  }
}
