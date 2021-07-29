import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/logic/cubit/add_work_details_cubit/add_work_details_cubit.dart';
import 'package:my_lms/logic/cubit/working_cubit/working_cubit.dart';
import 'package:my_lms/presentation/router/app_router.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:my_lms/presentation/screens/widgets/success_msg_box.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/screen_arguments/end_tab_args.dart';

class EndTab extends StatefulWidget {
  final EndTabArgs args;
  const EndTab({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _EndTabState createState() => _EndTabState();
}

class _EndTabState extends State<EndTab> {
  String startTime = "";
  String endTime = "";
  DateFormat formattedDate = DateFormat('HH:mm:ss');

  @override
  void initState() {
    super.initState();
    startTime = formattedDate.format(
        DateTime.fromMillisecondsSinceEpoch(widget.args.startTimestamp));
    endTime = formattedDate
        .format(DateTime.fromMillisecondsSinceEpoch(widget.args.endTimestamp));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundWhite,
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
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
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Working Time Tracker",
                      style: TextStyle(
                          color: MyColors.accentColor,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      width: 100.w,
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(5.w),
                        boxShadow: [MyStyles.boxShadow],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subject: ${widget.args.contentScreenArgs.subjectName}",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Module: ${widget.args.contentScreenArgs.moduleName}",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Content: ${widget.args.contentScreenArgs.contentName}",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Start time: $startTime",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "End time: $endTime",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Worked time: ${widget.args.clockValue}",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          BlocBuilder<AddWorkDetailsCubit, AddWorkDetailsState>(
            builder: (context, state) {
              if (state is AddWorkDetailsInitial) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(5.w),
                    boxShadow: [MyStyles.boxShadow],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Did you complete this content?",
                        style: TextStyle(
                            color: MyColors.shadedBlack,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                BlocProvider.of<AddWorkDetailsCubit>(context)
                                    .addWorkDetails(
                                        isCompleted: false,
                                        endTabArgs: widget.args),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 3.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyColors.shadedBlack, width: 0.5.w),
                                color: MyColors.white,
                                borderRadius: BorderRadius.circular(5.w),
                                boxShadow: [MyStyles.boxShadow],
                              ),
                              child: Center(
                                child: Text(
                                  "Not Yet",
                                  style: TextStyle(
                                      color: MyColors.shadedBlack,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                BlocProvider.of<AddWorkDetailsCubit>(context)
                                    .addWorkDetails(
                                        isCompleted: true,
                                        endTabArgs: widget.args),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 3.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyColors.green, width: 0.5.w),
                                color: MyColors.white,
                                borderRadius: BorderRadius.circular(5.w),
                                boxShadow: [MyStyles.boxShadow],
                              ),
                              child: Center(
                                child: Text(
                                  "Yes I Did",
                                  style: TextStyle(
                                      color: MyColors.green,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              } else if (state is AddWorkDetailsLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is AddWorkDetailsSucceed) {
                if (state.isCompleted) {
                  BlocProvider.of<WorkingCubit>(context)
                      .emit(WorkingContentCompleted());
                  return Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SuccessMsgBox(successMsg: "succeed!"),
                  ));
                } else {
                  return Column(
                    children: [
                      Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: SuccessMsgBox(successMsg: "succeed!"),
                      )),
                      SizedBox(
                        height: 2.h,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(AppRouter.authScreen,
                                (Route<dynamic> route) => false),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: MyColors.lightGray, width: 0.5.w),
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
                        height: 2.h,
                      ),
                    ],
                  );
                }
              } else if (state is AddWorkDetailsFailed) {
                return Column(
                  children: [
                    ErrorMsgBox(errorMsg: state.errorMsg),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextButton(
                      onPressed: () =>
                          BlocProvider.of<AddWorkDetailsCubit>(context)
                              .emit(AddWorkDetailsInitial()),
                      child: Text(
                        "Retry",
                        style: TextStyle(
                          color: MyColors.accentColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                );
              } else {
                return Center(
                  child: ErrorMsgBox(errorMsg: "unhandled state excecuted!"),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
