import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/models/cal_event_modle.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'show_events_state.dart';

class ShowEventsCubit extends Cubit<ShowEventsState> {
  ShowEventsCubit() : super(ShowEventsInitial());

  List<CalEvent> allEvents = [];

  Future<void> getAllEvents() async {
    try {
      emit(ShowEventsLoading());
      allEvents = await FirebaseRepo.getCalEvents();
      emit(ShowEventsLoaded(events: allEvents));
    } catch (e) {
      emit(ShowEventsFailed(errorMsg: e.toString()));
    }
  }
}
