import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/models/pie_data_model.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'today_works_state.dart';

class TodayWorksCubit extends Cubit<TodayWorksState> {
  TodayWorksCubit() : super(TodayWorksInitial());

  Future<void> loadTodayWorkCardData() async {
    try {
      emit(TodayWorksLoading(loadingMsg: "Loading..."));
      String workedTime = await FirebaseRepo.getTodayWorkedTime();
      List<PieDataModel> pieDataList = await FirebaseRepo.getPieDataList();
      emit(TodayWorksLoaded(workedTime: workedTime, pieDataList: pieDataList));
    } catch (e) {
      emit(TodayWorksFailed(errorMsg: e.toString()));
    }
  }
}
