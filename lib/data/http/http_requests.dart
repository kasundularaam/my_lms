import 'dart:convert';

import 'package:my_lms/data/data_providers/data_provider.dart';
import 'package:my_lms/data/models/content_model.dart';
import 'package:my_lms/data/models/module_model.dart';
import 'package:my_lms/data/models/question_model.dart';
import 'package:my_lms/data/models/subject_model.dart';
import 'package:http/http.dart' as http;

class HttpRequests {
  //Support funtions
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

  // backend functions

  static Future<List<Subject>> getSubjects() async {
    try {
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
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Module>> getModules({required String subjectId}) async {
    try {
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
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Content>> getContents({required String moduleId}) async {
    try {
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
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Question>> getQuestions({required String moduleId}) async {
    try {
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
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getContentCountBySub({required String subjectId}) async {
    try {
      final response = await http.get(
        Uri.parse(
          DataProvider.contentCountBySubUrl(subjectId: subjectId),
        ),
      );
      if (response.statusCode == 200) {
        int count = int.parse(response.body);
        return count;
      } else {
        throw '${response.statusCode}';
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getQuestionCountBySub({required String subjectId}) async {
    try {
      final response = await http.get(
        Uri.parse(
          DataProvider.questionCountBySubUrl(subjectId: subjectId),
        ),
      );
      if (response.statusCode == 200) {
        int count = int.parse(response.body);
        return count;
      } else {
        throw '${response.statusCode}';
      }
    } catch (e) {
      throw e;
    }
  }
}
