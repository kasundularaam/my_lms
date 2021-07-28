import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/data/http/http_requests.dart';
import 'package:my_lms/data/models/content_model.dart';

part 'module_screen_state.dart';

class ModuleScreenCubit extends Cubit<ModuleScreenState> {
  ModuleScreenCubit() : super(ModuleScreenInitial());

  Future<void> loadContentList({required String moduleId}) async {
    try {
      emit(ModuleScreenLoading());
      List<Content> contentList =
          await HttpRequests.getContents(moduleId: moduleId);
      emit(ModuleScreenLoaded(contentList: contentList));
    } catch (e) {
      emit(ModuleScreenFailed(errorMsg: e.toString()));
    }
  }
}
