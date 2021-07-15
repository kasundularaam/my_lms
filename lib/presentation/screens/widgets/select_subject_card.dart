import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/data/models/subject_model.dart';

class SelectSubjectCard extends StatefulWidget {
  final Subject subject;
  final Function(String) isSelected;
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
              widget.isSelected(widget.subject.id);
              setState(() {
                selected = false;
              });
            } else {
              widget.isSelected(widget.subject.id);
              setState(() {
                selected = true;
              });
            }
          },
          child: Container(
            height: 15.h,
            width: 90.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
                color: selected ? MyColors.accentColor : MyColors.white,
                borderRadius: BorderRadius.circular(5.w),
                boxShadow: [MyStyles.boxShadow]),
            child: Center(
              child: Text(
                widget.subject.name,
                style: TextStyle(
                    color: selected ? MyColors.white : MyColors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600),
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
