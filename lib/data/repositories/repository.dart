import 'package:my_lms/data/data_providers/data_provider.dart';
import 'package:my_lms/data/http/http_requests.dart';
import 'package:my_lms/data/models/content_model.dart';
import 'package:my_lms/data/models/module_model.dart';
import 'package:my_lms/data/models/question_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Repository {
  static Future<int> getModuleCountBySubId({required String subjectId}) async {
    try {
      List<Module> moduleList =
          await HttpRequests.getModules(subjectId: subjectId);
      return moduleList.length;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getContentCountByModId({required String moduleId}) async {
    try {
      List<Content> list = await HttpRequests.getContents(moduleId: moduleId);
      return list.length;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getQuizCountByModId({required String moduleId}) async {
    try {
      List<Question> list = await HttpRequests.getQuestion(moduleId: moduleId);
      return list.length;
    } catch (e) {
      throw e;
    }
  }

  static void downloadPdf({required String path}) {
    try {
      launch(DataProvider.pdfDownloadLink(path: path));
    } catch (e) {
      throw e;
    }
  }
}
