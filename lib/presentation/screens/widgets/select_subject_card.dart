import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/data/models/subject_model.dart';

class SelectSubjectCard extends StatefulWidget {
  final Subject subject;
  final Function(Subject) isSelected;
  const SelectSubjectCard({
    Key? key,
    required this.subject,
    required this.isSelected,
  }) : super(key: key);
  @override
  _SelectSubjectCardState createState() => _SelectSubjectCardState();
}

class _SelectSubjectCardState extends State<SelectSubjectCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (selected) {
              widget.isSelected(widget.subject);
              setState(() {
                selected = false;
              });
            } else {
              widget.isSelected(widget.subject);
              setState(() {
                selected = true;
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            decoration: BoxDecoration(
              color:
                  selected ? MyColors.progressColor : MyColors.textColorLight,
              borderRadius: BorderRadius.circular(5.w),
            ),
            child: Center(
              child: Text(
                widget.subject.name,
                style: TextStyle(
                  color: selected
                      ? MyColors.textColorDark
                      : MyColors.textColorDark,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.w,
        )
      ],
    );
  }
}
