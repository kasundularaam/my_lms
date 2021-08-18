import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:sizer/sizer.dart';

class AddEventMainScreen extends StatefulWidget {
  const AddEventMainScreen({Key? key}) : super(key: key);

  @override
  _AddEventMainScreenState createState() => _AddEventMainScreenState();
}

class _AddEventMainScreenState extends State<AddEventMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.screenBgDarkColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                Container(
                  height: (constraints.maxHeight * 10) / 100,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: MyColors.textColorLight,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Add Event",
                          style: TextStyle(
                              color: MyColors.textColorLight,
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: (constraints.maxHeight * 90) / 100,
                  decoration: BoxDecoration(
                    color: MyColors.screenBgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.w),
                      topRight: Radius.circular(8.w),
                    ),
                  ),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
