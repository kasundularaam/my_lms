import 'dart:convert';

class LmsUser {
  String uid;
  String name;
  String email;
  String streamId;
  LmsUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.streamId,
  });

  LmsUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? streamId,
  }) {
    return LmsUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      streamId: streamId ?? this.streamId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'streamId': streamId,
    };
  }

  factory LmsUser.fromMap(Map<String, dynamic> map) {
    return LmsUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      streamId: map['streamId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LmsUser.fromJson(String source) =>
      LmsUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, email: $email, streamId: $streamId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LmsUser &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.streamId == streamId;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ name.hashCode ^ email.hashCode ^ streamId.hashCode;
  }
}
