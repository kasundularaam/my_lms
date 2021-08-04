import 'package:flutter/material.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/presentation/screens/widgets/h_t_c_item_loading.dart';
import 'package:sizer/sizer.dart';

class HTCLoading extends StatelessWidget {
  const HTCLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      width: 90.w,
      decoration: BoxDecoration(
          color: MyColors.accentColor,
          borderRadius: BorderRadius.circular(5.w),
          boxShadow: [MyStyles.boxShadow]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subjects",
            style: TextStyle(color: MyColors.white, fontSize: 20.sp),
          ),
          SizedBox(
            height: 3.h,
          ),
          HTCItemLoadingW(),
          SizedBox(
            height: 3.h,
          ),
          HTCItemLoadingW(),
        ],
      ),
    );
  }
}
