class DataProvider {
  static String subjectUrl() {
    return "http://critssl.com/studyPlanner/subject.php";
  }

  static String moduleUrl({required String subjectId}) {
    return "http://critssl.com/studyPlanner/module.php?subject=$subjectId";
  }

  static String contentUrl({required String moduleId}) {
    return "http://critssl.com/studyPlanner/content.php?module=$moduleId";
  }

  static String questionUrl({required moduleId}) {
    return "http://critssl.com/studyPlanner/question.php?module=$moduleId";
  }
}
