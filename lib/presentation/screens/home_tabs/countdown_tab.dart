import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/logic/cubit/exam_countdown_cubit/exam_countdown_cubit.dart';
import 'package:my_lms/logic/cubit/pick_date_cubit/pick_date_cubit.dart';
import 'package:my_lms/logic/cubit/pick_time_cubit/pick_time_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/date_picker.dart';
import 'package:my_lms/presentation/screens/widgets/time_picker.dart';
import 'package:sizer/sizer.dart';

class CountDownTab extends StatefulWidget {
  const CountDownTab({Key? key}) : super(key: key);

  @override
  _CountDownTabState createState() => _CountDownTabState();
}

class _CountDownTabState extends State<CountDownTab> {
  DateTime? pickedDate;
  TimeOfDay? pickedTime;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExamCountdownCubit>(context).loadCountDown();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.w),
        bottomRight: Radius.circular(10.w),
      ),
      child: Container(
        color: MyColors.screenBgColor,
        child: BlocBuilder<ExamCountdownCubit, ExamCountdownState>(
          builder: (context, state) {
            if (state is ExamCountdownInitial) {
              return Center(child: Text("Initial State"));
            } else if (state is ExamCountdownLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: MyColors.progressColor,
              ));
            } else if (state is ExamCountdownRunning) {
              return Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Exam Countdown",
                        style: TextStyle(
                            color: MyColors.textColorLight,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      CountdownTimer(
                          endTime: state.examTimeStamp,
                          widgetBuilder: (context, time) {
                            String days = time!.days.toString().padLeft(2, '0');
                            String hours =
                                time.hours.toString().padLeft(2, '0');
                            String minutes =
                                time.min.toString().padLeft(2, '0');
                            String seconds =
                                time.sec.toString().padLeft(2, '0');
                            String miliSec =
                                time.milliseconds.toString().padLeft(2, '0');
                            return Column(
                              children: [
                                Text(
                                  days,
                                  style: TextStyle(
                                    color: MyColors.progressColor,
                                    fontSize: 40.sp,
                                  ),
                                ),
                                Text(
                                  "days",
                                  style: TextStyle(
                                    color: MyColors.textColorLight,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  hours,
                                  style: TextStyle(
                                    color: MyColors.progressColor,
                                    fontSize: 40.sp,
                                  ),
                                ),
                                Text(
                                  "hours",
                                  style: TextStyle(
                                    color: MyColors.textColorLight,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  minutes,
                                  style: TextStyle(
                                    color: MyColors.progressColor,
                                    fontSize: 40.sp,
                                  ),
                                ),
                                Text(
                                  "minutes",
                                  style: TextStyle(
                                    color: MyColors.textColorLight,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  seconds,
                                  style: TextStyle(
                                    color: MyColors.progressColor,
                                    fontSize: 40.sp,
                                  ),
                                ),
                                Text(
                                  "seconds",
                                  style: TextStyle(
                                    color: MyColors.textColorLight,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () => BlocProvider.of<ExamCountdownCubit>(context)
                          .emit(ExamCountdownEdit(available: true)),
                      child: Container(
                        margin: EdgeInsets.all(5.w),
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: MyColors.progressColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit_rounded,
                          size: 20.sp,
                          color: MyColors.textColorDark,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ExamCountdownEdit) {
              return Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Exam Countdown",
                        style: TextStyle(
                            color: MyColors.textColorLight,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text("Exam start date",
                          style: TextStyle(
                              color: MyColors.textColorLight, fontSize: 16.sp)),
                      SizedBox(
                        height: 2.h,
                      ),
                      BlocProvider(
                        create: (context) => PickDateCubit(),
                        child: DatePicker(
                            onSelectDate: (date) => pickedDate = date),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text("Exam start time",
                          style: TextStyle(
                              color: MyColors.textColorLight, fontSize: 16.sp)),
                      SizedBox(
                        height: 2.h,
                      ),
                      BlocProvider(
                        create: (context) => PickTimeCubit(),
                        child: TimePicker(
                            onPickedTime: (time) => pickedTime = time),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        state.available
                            ? GestureDetector(
                                onTap: () =>
                                    BlocProvider.of<ExamCountdownCubit>(context)
                                        .loadCountDown(),
                                child: Container(
                                  margin: EdgeInsets.all(5.w),
                                  padding: EdgeInsets.all(3.w),
                                  decoration: BoxDecoration(
                                    color: MyColors.progressColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 20.sp,
                                    color: MyColors.textColorDark,
                                  ),
                                ),
                              )
                            : SizedBox(),
                        GestureDetector(
                          onTap: () {
                            if (pickedDate != null && pickedTime != null) {
                              BlocProvider.of<ExamCountdownCubit>(context)
                                  .setExamDateTime(
                                      dateTime: pickedDate!,
                                      timeOfDay: pickedTime!);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(5.w),
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: MyColors.progressColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              size: 20.sp,
                              color: MyColors.textColorDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    if (pickedDate != null && pickedTime != null) {
                      BlocProvider.of<ExamCountdownCubit>(context)
                          .setExamDateTime(
                              dateTime: pickedDate!, timeOfDay: pickedTime!);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(5.w),
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: MyColors.progressColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      size: 20.sp,
                      color: MyColors.textColorDark,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
