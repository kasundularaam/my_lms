import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/shared_prefs_keys.dart';
import 'package:my_lms/logic/cubit/working_cubit/working_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/core/screen_arguments/content_screen_args.dart';
import 'package:my_lms/logic/cubit/timer_cubit/timer_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';

class InitTab extends StatefulWidget {
  final ContentScreenArgs args;
  const InitTab({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _InitTabState createState() => _InitTabState();
}

class _InitTabState extends State<InitTab> {
  Future<void> checkSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isOnWorking = prefs.getBool(SharedPrefsKeys.isOnWorkingKey);
    if (isOnWorking != null) {
      if (isOnWorking) {
        int startTimeStampSp =
            prefs.getInt(SharedPrefsKeys.startTimeStampKey) ?? 0;
        BlocProvider.of<TimerCubit>(context)
            .backToWork(startTimeStampSp: startTimeStampSp);
      } else {
        BlocProvider.of<TimerCubit>(context)
            .emit(TimerInitial(initCounter: "00.00.00"));
      }
    } else {
      BlocProvider.of<TimerCubit>(context)
          .emit(TimerInitial(initCounter: "00.00.00"));
    }
  }

  @override
  void initState() {
    super.initState();
    checkSP();
  }

  @override
  void dispose() {
    BlocProvider.of<TimerCubit>(context).cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundWhite,
      body: ListView(
        padding: EdgeInsets.all(0),
        physics: BouncingScrollPhysics(),
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
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(5.w),
                        boxShadow: [MyStyles.boxShadow],
                      ),
                      child: Center(
                        child: BlocBuilder<TimerCubit, TimerState>(
                          builder: (context, state) {
                            if (state is TimerInitial) {
                              return Text(
                                state.initCounter,
                                style: TextStyle(
                                    color: MyColors.shadedBlack,
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w600),
                              );
                            } else if (state is TimerStarted) {
                              return Text(
                                state.startedCounter,
                                style: TextStyle(
                                    color: MyColors.shadedBlack,
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w600),
                              );
                            } else if (state is TimerRunning) {
                              return Text(
                                state.timeCounter,
                                style: TextStyle(
                                    color: MyColors.shadedBlack,
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w600),
                              );
                            } else if (state is TimerEnded) {
                              return Text(
                                state.args.clockValue,
                                style: TextStyle(
                                    color: MyColors.shadedBlack,
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.w600),
                              );
                            } else {
                              return ErrorMsgBox(errorMsg: "an error occered!");
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
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
                            "Subject: ${widget.args.subjectName}",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Module: ${widget.args.moduleName}",
                            style: TextStyle(
                                color: MyColors.shadedBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Content: ${widget.args.contentName}",
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
            height: 5.h,
          ),
          BlocBuilder<TimerCubit, TimerState>(
            builder: (context, state) {
              if (state is TimerInitial) {
                return GestureDetector(
                  onTap: () => BlocProvider.of<TimerCubit>(context).startTimer(
                      notifMsg: widget.args.contentName, args: widget.args),
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      color: MyColors.green,
                      borderRadius: BorderRadius.circular(5.w),
                      boxShadow: [MyStyles.boxShadow],
                    ),
                    child: Center(
                      child: Text(
                        "Start",
                        style: TextStyle(
                            color: MyColors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                );
              } else if (state is TimerStarted) {
                return Container(
                  padding: EdgeInsets.all(5.w),
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color: MyColors.red,
                    borderRadius: BorderRadius.circular(5.w),
                    boxShadow: [MyStyles.boxShadow],
                  ),
                  child: Center(
                    child: Text(
                      "Stop",
                      style: TextStyle(
                          color: MyColors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              } else if (state is TimerRunning) {
                return GestureDetector(
                  onTap: () => BlocProvider.of<TimerCubit>(context)
                      .endTimer(contentScreenArgs: widget.args),
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      color: MyColors.red,
                      borderRadius: BorderRadius.circular(5.w),
                      boxShadow: [MyStyles.boxShadow],
                    ),
                    child: Center(
                      child: Text(
                        "Stop",
                        style: TextStyle(
                            color: MyColors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                );
              } else if (state is TimerEnded) {
                BlocProvider.of<WorkingCubit>(context).emit(
                  WorkingEnded(
                    args: state.args,
                  ),
                );
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
