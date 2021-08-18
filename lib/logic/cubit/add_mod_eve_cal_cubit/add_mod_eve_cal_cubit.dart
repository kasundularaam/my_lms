import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/models/add_eve_cal_cu_model.dart';
import 'package:my_lms/data/models/cal_event_modle.dart';
import 'package:my_lms/data/repositories/calandar_repo.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'add_mod_eve_cal_state.dart';

class AddModEveCalCubit extends Cubit<AddModEveCalState> {
  AddModEveCalCubit() : super(AddModEveCalInitial());

  Future<void> addModEveToCal(
      {required AddEvCalCuMod addEvCalCuMod, required int count}) async {
    try {
      DateTime selectedDateTime = DateTime(
        addEvCalCuMod.date.year,
        addEvCalCuMod.date.month,
        addEvCalCuMod.date.day,
        addEvCalCuMod.time.hour,
        addEvCalCuMod.time.minute,
      );
      List<Event> events = [];
      for (int i = 0; i < count; i++) {
        DateTime eveStartTime = selectedDateTime.add(Duration(days: (7 * i)));
        DateTime eventEndTime = eveStartTime.add(Duration(hours: 2));
        Event event = new Event();
        EventDateTime start = new EventDateTime();
        start.dateTime = eveStartTime;
        start.timeZone = "GMT+5:30";
        event.start = start;

        EventDateTime end = new EventDateTime();
        end.timeZone = "GMT+5:30";
        end.dateTime = eventEndTime;
        event.end = end;
        int weekInt = i++;
        event.summary =
            "${addEvCalCuMod.subjectName} > ${addEvCalCuMod.moduleName} | week $weekInt";
        events.add(event);
      }
      List<String?> eventIds =
          await CalandarRepo.addModEveToCal(events: events);
      List<CalEvent> eventsForFire = [];
      int weekIntForFire = 1;
      int indexForFire = 0;
      eventIds.forEach((singleEventId) {
        if (singleEventId != null) {
          if (singleEventId.isNotEmpty) {
            String titleForFire =
                "${addEvCalCuMod.subjectName} > ${addEvCalCuMod.moduleName} | week $weekIntForFire";
            int timeForFire = selectedDateTime
                .add(Duration(days: (7 * indexForFire)))
                .millisecondsSinceEpoch;
            eventsForFire.add(
              CalEvent(
                id: singleEventId,
                title: titleForFire,
                time: timeForFire,
                type: "module",
                subjectId: addEvCalCuMod.subjectId,
                subjectName: addEvCalCuMod.subjectName,
                moduleId: addEvCalCuMod.moduleId,
                moduleName: addEvCalCuMod.moduleName,
                contentId: "",
                contentName: "",
              ),
            );
          }
        }
        weekIntForFire++;
        indexForFire++;
      });
      await FirebaseRepo.addModEveToCal(calEvents: eventsForFire);
      emit(AddModEveCalSucceed());
    } catch (e) {
      emit(AddModEveCalFailed(errorMsg: e.toString()));
    }
  }
}
