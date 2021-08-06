import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:sizer/sizer.dart';

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
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.w),
          color: MyColors.progressColor,
        ),
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: 18.sp,
              color: MyColors.textColorDark,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
