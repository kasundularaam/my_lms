import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/models/cal_event_modle.dart';
import 'package:my_lms/data/repositories/calandar_repo.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'add_event_cal_state.dart';

class AddEventCalCubit extends Cubit<AddEventCalState> {
  AddEventCalCubit() : super(AddEventCalInitial());

  Future<void> addEventToCal(
      {required DateTime date,
      required TimeOfDay time,
      required String title}) async {
    try {
      emit(AddEventCalLoading());
      DateTime startTime =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      DateTime endTime = startTime.add(Duration(hours: 2));
      Event event = new Event();
      EventDateTime start = new EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+5:30";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+5:30";
      end.dateTime = endTime;
      event.end = end;
      event.summary = title;
      String? eventId = await CalandarRepo.addEvent(event);
      if (eventId != null) {
        await FirebaseRepo.addCalEvents(
            calEvent: CalEvent(
                id: eventId,
                title: title,
                time: startTime.millisecondsSinceEpoch));
        emit(AddEventCalSucceed());
      } else {
        emit(AddEventCalFailed(
            errorMsg: "Unable to add event in google calendar"));
      }
    } catch (e) {
      emit(AddEventCalFailed(errorMsg: e.toString()));
    }
  }
}
