// To parse this JSON data, do
//
//     final fireSubject = fireSubjectFromJson(jsonString);

import 'dart:convert';

FireSubject fireSubjectFromJson(String str) =>
    FireSubject.fromJson(json.decode(str));

String fireSubjectToJson(FireSubject data) => json.encode(data.toJson());

class FireSubject {
  FireSubject({
    required this.id,
    required this.name,
    required this.isCompleted,
  });

  String id;
  String name;
  bool isCompleted;

  factory FireSubject.fromJson(Map<String, dynamic> json) => FireSubject(
        id: json["id"],
        name: json["name"],
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isCompleted": isCompleted,
      };
}
