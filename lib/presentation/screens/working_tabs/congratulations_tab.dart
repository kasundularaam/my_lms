import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:sizer/sizer.dart';

class CongratulationsTab extends StatefulWidget {
  const CongratulationsTab({Key? key}) : super(key: key);

  @override
  _CongratulationsTabState createState() => _CongratulationsTabState();
}

class _CongratulationsTabState extends State<CongratulationsTab> {
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
                    child: Column(
                      children: [
                        Text(
                          "GREETINGS",
                          style: TextStyle(
                              color: MyColors.green,
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "🎉",
                          style: TextStyle(
                            fontSize: 50.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "congratulations you have successfully completed content 2",
                    style: TextStyle(
                        color: MyColors.gray,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
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
            onTap: () => {},
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
                  "Back To Home",
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
          GestureDetector(
            onTap: () => {},
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
                  "Back To Module",
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
          GestureDetector(
            onTap: () => {},
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
                  "Back To Content",
                  style: TextStyle(
                      color: MyColors.shadedBlack,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
