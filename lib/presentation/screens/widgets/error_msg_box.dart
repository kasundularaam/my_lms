import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:sizer/sizer.dart';

class ErrorMsgBox extends StatelessWidget {
  final String errorMsg;
  const ErrorMsgBox({
    Key? key,
    required this.errorMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: MyColors.errorBackground,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Text(
        errorMsg,
        style: TextStyle(
            color: MyColors.primaryError,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
