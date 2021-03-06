import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/models/cal_event_modle.dart';
import 'package:my_lms/data/repositories/firebase_repo/firebase_cal_repo.dart';

part 'show_cal_events_state.dart';

class ShowCalEventsCubit extends Cubit<ShowCalEventsState> {
  ShowCalEventsCubit() : super(ShowCalEventsInitial());

  Future<void> loadEvents() async {
    try {
      emit(ShowCalEventsLoading());
      List<CalEvent> calEvents = await FirebaseCalRepo.getCalEvents();
      if (calEvents.isNotEmpty) {
        emit(ShowCalEventsLoaded(calEvents: calEvents));
      } else {
        emit(ShowCalEventsNoResult(message: "No results found"));
      }
    } catch (e) {
      emit(ShowCalEventsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> searchEvents({required String searchText}) async {
    try {
      emit(ShowCalEventsLoading());
      String lCaseText = searchText.toLowerCase();
      List<CalEvent> calEvents = await FirebaseCalRepo.getCalEvents();
      List<CalEvent> filteredList = [];
      if (calEvents.isNotEmpty) {
        calEvents.forEach((singleEvent) {
          DateFormat dayFormat = DateFormat("dd");
          String day = dayFormat
              .format(DateTime.fromMillisecondsSinceEpoch(singleEvent.time));
          DateFormat monYrFormat = DateFormat("MMM");
          String month = monYrFormat
              .format(DateTime.fromMillisecondsSinceEpoch(singleEvent.time));
          if (singleEvent.title.toLowerCase().contains(lCaseText) ||
              day.toLowerCase().contains(lCaseText) ||
              month.toLowerCase().contains(lCaseText)) {
            filteredList.add(singleEvent);
          }
        });
        if (filteredList.isNotEmpty) {
          emit(ShowCalEventsLoaded(calEvents: filteredList));
        } else {
          emit(ShowCalEventsNoResult(message: "No results found"));
        }
      } else {
        emit(ShowCalEventsNoResult(message: "No results found"));
      }
    } catch (e) {
      emit(ShowCalEventsFailed(errorMsg: e.toString()));
    }
  }
}
