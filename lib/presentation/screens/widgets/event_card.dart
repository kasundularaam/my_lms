import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/data/models/cal_event_modle.dart';

class EventCard extends StatelessWidget {
  final CalEvent calEvent;
  const EventCard({
    Key? key,
    required this.calEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dayFormat = DateFormat("dd");
    String day =
        dayFormat.format(DateTime.fromMillisecondsSinceEpoch(calEvent.time));
    DateFormat monYrFormat = DateFormat("MMM.yyyy");
    String monYear =
        monYrFormat.format(DateTime.fromMillisecondsSinceEpoch(calEvent.time));
    return Column(
      children: [
        Container(
            child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Text(
                    day,
                    style: TextStyle(
                        color: MyColors.textColorDark, fontSize: 24.sp),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.w),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          calEvent.title,
                          style: TextStyle(
                              color: MyColors.textColorDark, fontSize: 14.sp),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          monYear,
                          style: TextStyle(
                              color: MyColors.textColorDark, fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        )),
        SizedBox(
          height: 5.w,
        )
      ],
    );
  }
}
