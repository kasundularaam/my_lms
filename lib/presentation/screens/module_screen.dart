import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:sizer/sizer.dart';

class ModuleScreen extends StatefulWidget {
  final String moduleId;
  final String moduleName;
  const ModuleScreen({
    Key? key,
    required this.moduleId,
    required this.moduleName,
  }) : super(key: key);

  @override
  _ModuleScreenState createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundWhite,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 5.h,
          ),
          Text(
            widget.moduleName,
            style: TextStyle(
                color: MyColors.accentColor,
                fontSize: 32.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30.w,
          ),
          Container(
            width: 90.w,
            padding: EdgeInsets.symmetric(vertical: 3.w),
            decoration: BoxDecoration(
              color: MyColors.offWhite,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [MyStyles.boxShadow],
            ),
            child: Column(
              children: [
                Text(
                  "Contents",
                  style: TextStyle(
                      color: MyColors.accentColor,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 3.w,
                ),
                Container(
                  height: 16.h,
                  width: 90.w,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return SizedBox(
                          width: 2.w,
                        );
                      } else if (index != 1 && index < 6) {
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 15.h,
                                  width: 50.w,
                                  padding: EdgeInsets.all(5.w),
                                  decoration: BoxDecoration(
                                    color: MyColors.accentColor,
                                    borderRadius: BorderRadius.circular(5.w),
                                    boxShadow: [MyStyles.boxShadow],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Content 0$index",
                                      style: TextStyle(
                                          color: MyColors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            )
                          ],
                        );
                      } else if (index == 6) {
                        return Container(
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            color: MyColors.offWhite,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "See All",
                                style: TextStyle(
                                    color: MyColors.shadedBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 20.sp,
                                color: MyColors.shadedBlack,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: 2.w,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 10.h,
            width: 50.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: MyColors.accentColor,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [MyStyles.boxShadow],
            ),
            child: Center(
              child: Text(
                "Go To Quiz",
                style: TextStyle(
                    color: MyColors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
