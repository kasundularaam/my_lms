import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/models/fire_content.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'work_card_list_state.dart';

class WorkCardListCubit extends Cubit<WorkCardListState> {
  WorkCardListCubit() : super(WorkCardListInitial());

  Future<void> loadFireContentList() async {
    try {
      emit(WorkCardListLoading());
      List<FireContent> fireContents = await FirebaseRepo.getFireContents();
      emit(WorkCardListLoaded(fireContents: fireContents));
    } catch (e) {
      emit(WorkCardListFailed(errorMsg: e.toString()));
    }
  }
}
