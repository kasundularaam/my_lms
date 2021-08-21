import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:sizer/sizer.dart';

class ChangePasswordCard extends StatefulWidget {
  const ChangePasswordCard({Key? key}) : super(key: key);

  @override
  _ChangePasswordCardState createState() => _ChangePasswordCardState();
}

class _ChangePasswordCardState extends State<ChangePasswordCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
          color: MyColors.textColorLight,
          borderRadius: BorderRadius.circular(2.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Change Password",
            style: TextStyle(
              color: MyColors.textColorDark,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextField(
            onChanged: (t) {},
            style: TextStyle(
              fontSize: 14.sp,
              color: MyColors.textColorDark,
            ),
            decoration: InputDecoration(hintText: "Current Password"),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextField(
            onChanged: (t) {},
            style: TextStyle(
              fontSize: 14.sp,
              color: MyColors.textColorDark,
            ),
            decoration: InputDecoration(hintText: "New Password"),
          ),
          SizedBox(
            height: 2.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  "SAVE",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: MyColors.green,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
