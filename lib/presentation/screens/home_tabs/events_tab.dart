import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:sizer/sizer.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({Key? key}) : super(key: key);

  @override
  _EventsTabState createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.w),
        bottomRight: Radius.circular(10.w),
      ),
      child: Container(
        color: MyColors.screenBgColor,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          children: [
            SizedBox(
              height: 2.h,
            ),
            Text(
              "Events",
              style: TextStyle(
                  color: MyColors.textColorLight,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
