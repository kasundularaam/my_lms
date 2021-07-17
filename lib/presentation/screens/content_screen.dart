import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  final String contentId;
  final String contentName;
  const ContentScreen({
    Key? key,
    required this.contentId,
    required this.contentName,
  }) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("content screen"),
      ),
    );
  }
}
