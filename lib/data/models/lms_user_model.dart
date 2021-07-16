import 'dart:convert';

import 'package:flutter/foundation.dart';

class LmsUser {
  String uid;
  String name;
  String email;
  LmsUser({
    required this.uid,
    required this.name,
    required this.email,
  });

  LmsUser copyWith({
    String? uid,
    String? name,
    String? email,
  }) {
    return LmsUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  factory LmsUser.fromMap(Map<String, dynamic> map) {
    return LmsUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LmsUser.fromJson(String source) =>
      LmsUser.fromMap(json.decode(source));

  @override
  String toString() => 'LmsUser(uid: $uid, name: $name, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LmsUser &&
        other.uid == uid &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ email.hashCode;
}
