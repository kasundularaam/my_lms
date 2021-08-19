import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
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
        calEvents.forEach((singleEent) {
          if (singleEent.subjectName.toLowerCase().contains(lCaseText) ||
              singleEent.moduleName.toLowerCase().contains(lCaseText) ||
              singleEent.contentName.toLowerCase().contains(lCaseText)) {
            filteredList.add(singleEent);
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
