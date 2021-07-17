import 'dart:convert';

import 'package:my_lms/data/data_providers/data_provider.dart';
import 'package:my_lms/data/models/content_model.dart';
import 'package:my_lms/data/models/module_model.dart';
import 'package:my_lms/data/models/question_model.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:http/http.dart' as http;

class HttpRequests {
  static List<Subject> parseSubject(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Subject>(
          (json) => Subject.fromJson(json),
        )
        .toList();
  }

  static List<Module> parseModule(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Module>(
          (json) => Module.fromJson(json),
        )
        .toList();
  }

  static List<Content> parseContent(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Content>(
          (json) => Content.fromJson(json),
        )
        .toList();
  }

  static List<Question> parseQuestion(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Question>(
          (json) => Question.fromJson(json),
        )
        .toList();
  }

  static Future<List<Subject>> getSubjects() async {
    final response = await http.get(
      Uri.parse(
        DataProvider.subjectUrl(),
      ),
    );
    if (response.statusCode == 200) {
      List<Subject> subjectList = parseSubject(response.body);
      return subjectList;
    } else {
      throw '${response.statusCode}';
    }
  }

  static Future<List<Module>> getModules({required String subjectId}) async {
    final response = await http.get(
      Uri.parse(
        DataProvider.moduleUrl(subjectId: subjectId),
      ),
    );
    if (response.statusCode == 200) {
      List<Module> moduleList = parseModule(response.body);
      return moduleList;
    } else {
      throw '${response.statusCode}';
    }
  }

  static Future<List<Content>> getContent({required String moduleId}) async {
    final response = await http.get(
      Uri.parse(
        DataProvider.contentUrl(moduleId: moduleId),
      ),
    );
    if (response.statusCode == 200) {
      List<Content> contentList = parseContent(response.body);
      return contentList;
    } else {
      throw '${response.statusCode}';
    }
  }

  static Future<List<Question>> getQuestion({required String moduleId}) async {
    final response = await http.get(
      Uri.parse(
        DataProvider.questionUrl(moduleId: moduleId),
      ),
    );
    if (response.statusCode == 200) {
      List<Question> questionList = parseQuestion(response.body);
      return questionList;
    } else {
      throw '${response.statusCode}';
    }
  }

  static Future<List<Content>> getContentBySub(
      {required String subjectId}) async {
    final response = await http.get(
      Uri.parse(
        DataProvider.contentBySubUrl(subjectId: subjectId),
      ),
    );
    if (response.statusCode == 200) {
      List<Content> contentList = parseContent(response.body);
      return contentList;
    } else {
      throw '${response.statusCode}';
    }
  }

  static Future<List<Question>> getQuestionBySub(
      {required String subjectId}) async {
    final response = await http.get(
      Uri.parse(
        DataProvider.questionBySubUrl(subjectId: subjectId),
      ),
    );
    if (response.statusCode == 200) {
      List<Question> questionList = parseQuestion(response.body);
      return questionList;
    } else {
      throw '${response.statusCode}';
    }
  }
}
