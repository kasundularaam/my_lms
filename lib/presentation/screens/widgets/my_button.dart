import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String btnText;
  final Function onPressed;
  const MyButton({
    Key? key,
    required this.btnText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.lightGreen.withOpacity(0.7)),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}
