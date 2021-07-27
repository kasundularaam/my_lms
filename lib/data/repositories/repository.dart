import 'package:my_lms/data/data_providers/data_provider.dart';
import 'package:my_lms/data/http/http_client.dart';
import 'package:my_lms/data/models/module_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Repository {
  static Future<int> getModuleCount({required String subjectId}) async {
    try {
      List<Module> moduleList =
          await HttpRequests.getModules(subjectId: subjectId);
      return moduleList.length;
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
