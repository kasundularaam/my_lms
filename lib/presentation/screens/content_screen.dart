import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:sizer/sizer.dart';

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
      backgroundColor: MyColors.backgroundWhite,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 50.h,
            width: 100.w,
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
                    height: 5.h,
                  ),
                  Text(
                    widget.contentName,
                    style: TextStyle(
                        color: MyColors.accentColor,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      padding: EdgeInsets.all(5.w),
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: MyColors.accentColor,
                        borderRadius: BorderRadius.circular(5.w),
                        boxShadow: [MyStyles.boxShadow],
                      ),
                      child: Center(
                        child: Text(
                          "Download Content As a PDF",
                          style: TextStyle(
                              color: MyColors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () => {},
            child: Container(
              padding: EdgeInsets.all(5.w),
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                color: MyColors.accentColor,
                borderRadius: BorderRadius.circular(5.w),
                boxShadow: [MyStyles.boxShadow],
              ),
              child: Center(
                child: Text(
                  "Start Working",
                  style: TextStyle(
                      color: MyColors.white,
                      fontSize: 18.sp,
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
