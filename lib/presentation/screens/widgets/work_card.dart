import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/data/models/fire_content.dart';

class WorkCard extends StatelessWidget {
  final FireContent fireContent;
  const WorkCard({
    Key? key,
    required this.fireContent,
  }) : super(key: key);

  String workedTimeStr({required int counter}) {
    String hoursStr =
        ((counter / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    String minutesStr =
        ((counter / 60) % 60).floor().toString().padLeft(2, '0');
    String secondsStr = (counter % 60).floor().toString().padLeft(2, '0');
    String timeString = "$hoursStr" ":" "$minutesStr" ":" "$secondsStr";
    return timeString;
  }

  @override
  Widget build(BuildContext context) {
    String workedTime = workedTimeStr(counter: fireContent.counter);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
              color: MyColors.textColorLight,
              borderRadius: BorderRadius.circular(5.w)),
          child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/images/boy.jpg",
                      width: 10.w,
                      height: 10.w,
                    ),
                  ),
                  Text(
                    "You",
                    style: TextStyle(
                        color: MyColors.hpTopCardBgColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(fireContent.isCompleted
                      ? "Complted a content on"
                      : "Worked on"),
                ],
              ),
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(color: MyColors.offWhite),
                child: Text(
                    "${fireContent.subjectName} > ${fireContent.moduleName} > ${fireContent.contentName}"),
              ),
              Text("Worked time: $workedTime"),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  timeago.format(
                    DateTime.fromMillisecondsSinceEpoch(
                        fireContent.startTimestamp),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3.h,
        )
      ],
    );
  }
}
