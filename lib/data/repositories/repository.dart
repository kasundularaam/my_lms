import 'package:my_lms/data/http/http_client.dart';
import 'package:my_lms/data/models/content_model.dart';
import 'package:my_lms/data/models/module_model.dart';
import 'package:my_lms/data/models/question_model.dart';

class Repository {
  static Future<int> getModuleCount({required String subjectId}) async {
    List<Module> moduleList =
        await HttpRequests.getModules(subjectId: subjectId);
    return moduleList.length;
  }

  static Future<int> getContentCountBySub({required subjectId}) async {
    List<Content> contentList =
        await HttpRequests.getContentBySub(subjectId: subjectId);
    return contentList.length;
  }

  static Future<int> getQuizCountBySub({required subjectId}) async {
    List<Question> quizList =
        await HttpRequests.getQuestionBySub(subjectId: subjectId);
    return quizList.length;
  }
}
