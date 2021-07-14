import 'dart:convert';

import 'package:flutter/foundation.dart';

class LmsUser {
  String uid;
  String name;
  String email;
  List<String> subjectList;
  LmsUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.subjectList,
  });

  LmsUser copyWith({
    String? uid,
    String? name,
    String? email,
    List<String>? subjectList,
  }) {
    return LmsUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      subjectList: subjectList ?? this.subjectList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'subjectList': subjectList,
    };
  }

  factory LmsUser.fromMap(Map<String, dynamic> map) {
    return LmsUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      subjectList: List<String>.from(map['subjectList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LmsUser.fromJson(String source) =>
      LmsUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LmsUser(uid: $uid, name: $name, email: $email, subjectList: $subjectList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LmsUser &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        listEquals(other.subjectList, subjectList);
  }

  @override
  int get hashCode {
    return uid.hashCode ^ name.hashCode ^ email.hashCode ^ subjectList.hashCode;
  }
}
