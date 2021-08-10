import 'dart:convert';

class CalEvent {
  final String id;
  final String title;
  final int time;
  CalEvent({
    required this.id,
    required this.title,
    required this.time,
  });

  CalEvent copyWith({
    String? id,
    String? title,
    int? time,
  }) {
    return CalEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time': time,
    };
  }

  factory CalEvent.fromMap(Map<String, dynamic> map) {
    return CalEvent(
      id: map['id'],
      title: map['title'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CalEvent.fromJson(String source) =>
      CalEvent.fromMap(json.decode(source));

  @override
  String toString() => 'CalEvent(id: $id, title: $title, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalEvent &&
        other.id == id &&
        other.title == title &&
        other.time == time;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ time.hashCode;
}
