import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/data/models/cal_event_modle.dart';
import 'package:my_lms/logic/cubit/show_cal_events_cubit/show_cal_events_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:my_lms/presentation/screens/widgets/event_card.dart';
import 'package:my_lms/presentation/screens/widgets/my_text_field.dart';
import 'package:sizer/sizer.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({Key? key}) : super(key: key);

  @override
  _EventsTabState createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShowCalEventsCubit>(context).loadEvents();
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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
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
            SizedBox(
              height: 3.h,
            ),
            GestureDetector(
              onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (bottomSheetContext) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            "Add Reminder to",
                            style: TextStyle(
                              color: MyColors.textColorDark,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        ListTile(
                          leading: new Icon(Icons.person_rounded),
                          title: new Text("Module"),
                          onTap: () {
                            Navigator.pop(bottomSheetContext);
                          },
                        ),
                        ListTile(
                          leading: new Icon(Icons.group_rounded),
                          title: new Text("Content"),
                          onTap: () {
                            Navigator.pop(bottomSheetContext);
                          },
                        ),
                      ],
                    );
                  }),
              child: Container(
                decoration: BoxDecoration(
                    color: MyColors.textColorLight,
                    borderRadius: BorderRadius.circular(3.w)),
                padding: EdgeInsets.all(5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.event_note_rounded),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "Add new reminder",
                          style: TextStyle(
                            color: MyColors.textColorDark,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.add),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            MyTextField(
              onChanged: (text) => BlocProvider.of<ShowCalEventsCubit>(context)
                  .searchEvents(searchText: text),
              onSubmitted: (text) {},
              textInputAction: TextInputAction.search,
              isPassword: false,
              hintText: "Find event",
            ),
            SizedBox(
              height: 3.h,
            ),
            BlocBuilder<ShowCalEventsCubit, ShowCalEventsState>(
              builder: (context, state) {
                if (state is ShowCalEventsInitial) {
                  return Center(child: Text("Initial Event"));
                } else if (state is ShowCalEventsLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: MyColors.progressColor,
                    ),
                  );
                } else if (state is ShowCalEventsLoaded) {
                  return ListView.builder(
                    padding: EdgeInsets.all(0),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.calEvents.length,
                    itemBuilder: (BuildContext context, int index) {
                      CalEvent calEvent = state.calEvents[index];
                      return EventCard(calEvent: calEvent);
                    },
                  );
                } else if (state is ShowCalEventsFailed) {
                  return Center(
                    child: ErrorMsgBox(
                      errorMsg: state.errorMsg,
                    ),
                  );
                } else if (state is ShowCalEventsNoResult) {
                  return Center(
                    child: ErrorMsgBox(
                      errorMsg: state.message,
                    ),
                  );
                } else {
                  return Center(
                      child:
                          ErrorMsgBox(errorMsg: "unhandled state excecuted!"));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
