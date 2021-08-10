import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/screen_arguments/add_event_screen_args.dart';
import 'package:my_lms/logic/cubit/add_event_cal_cubit/add_event_cal_cubit.dart';
import 'package:my_lms/logic/cubit/pick_date_cubit/pick_date_cubit.dart';
import 'package:my_lms/logic/cubit/pick_time_cubit/pick_time_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/date_picker.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:my_lms/presentation/screens/widgets/success_msg_box.dart';
import 'package:my_lms/presentation/screens/widgets/time_picker.dart';

class AddEventScreen extends StatefulWidget {
  final AddEventScreenArgs args;
  const AddEventScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  String title = "";
  @override
  Widget build(BuildContext context) {
    title =
        "${widget.args.subjectName} > ${widget.args.moduleName} > ${widget.args.contentName}";
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
                        "Set Remainder",
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
                  padding: EdgeInsets.all(5.w),
                  children: [
                    Text("Content",
                        style: TextStyle(
                            color: MyColors.textColorLight, fontSize: 16.sp)),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: MyColors.textColorLight,
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: MyColors.textColorDark, fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text("Date",
                        style: TextStyle(
                            color: MyColors.textColorLight, fontSize: 16.sp)),
                    SizedBox(
                      height: 3.h,
                    ),
                    BlocProvider(
                      create: (context) => PickDateCubit(),
                      child:
                          DatePicker(onSelectDate: (date) => pickedDate = date),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text("time",
                        style: TextStyle(
                            color: MyColors.textColorLight, fontSize: 16.sp)),
                    SizedBox(
                      height: 3.h,
                    ),
                    BlocProvider(
                      create: (context) => PickTimeCubit(),
                      child:
                          TimePicker(onPickedTime: (time) => pickedTime = time),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    BlocBuilder<AddEventCalCubit, AddEventCalState>(
                      builder: (context, state) {
                        if (state is AddEventCalInitial) {
                          return GestureDetector(
                            onTap: () {
                              if (pickedDate != null && pickedTime != null) {
                                BlocProvider.of<AddEventCalCubit>(context)
                                    .addEventToCal(
                                        date: pickedDate!,
                                        time: pickedTime!,
                                        title: title);
                              } else {
                                print("date or time not picked");
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(5.w),
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              decoration: BoxDecoration(
                                color: MyColors.progressColor,
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: MyColors.textColorDark,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (state is AddEventCalLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is AddEventCalSucceed) {
                          return Center(
                              child:
                                  SuccessMsgBox(successMsg: "Remainder added"));
                        } else if (state is AddEventCalFailed) {
                          return Center(
                              child: ErrorMsgBox(errorMsg: state.errorMsg));
                        } else {
                          return Text("");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
