import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/presentation/router/app_router.dart';

class WorkingOnAnotherTab extends StatefulWidget {
  final String contentName;
  const WorkingOnAnotherTab({
    Key? key,
    required this.contentName,
  }) : super(key: key);

  @override
  _WorkingOnAnotherTabState createState() => _WorkingOnAnotherTabState();
}

class _WorkingOnAnotherTabState extends State<WorkingOnAnotherTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundWhite,
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: MyColors.offWhite,
              boxShadow: [MyStyles.boxShadow],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.w),
                bottomRight: Radius.circular(10.w),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.w),
                bottomRight: Radius.circular(10.w),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.green, width: 0.5.w),
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(5.w),
                      boxShadow: [MyStyles.boxShadow],
                    ),
                    child: Text(
                      "You are currently working on ${widget.contentName}. please pay your attention to the work",
                      style: TextStyle(
                          color: MyColors.green,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouter.authScreen, (Route<dynamic> route) => false),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.lightGray, width: 0.5.w),
                color: MyColors.offWhite,
                borderRadius: BorderRadius.circular(5.w),
                boxShadow: [MyStyles.boxShadow],
              ),
              child: Center(
                child: Text(
                  "Back To Work",
                  style: TextStyle(
                      color: MyColors.shadedBlack,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }
}
