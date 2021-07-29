import 'dart:convert';

class FireModule {
  final String id;
  final String name;
  final bool isCompleted;
  FireModule({
    required this.id,
    required this.name,
    required this.isCompleted,
  });

  FireModule copyWith({
    String? id,
    String? name,
    bool? isCompleted,
  }) {
    return FireModule(
      id: id ?? this.id,
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isCompleted': isCompleted,
    };
  }

  factory FireModule.fromMap(Map<String, dynamic> map) {
    return FireModule(
      id: map['id'],
      name: map['name'],
      isCompleted: map['isCompleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FireModule.fromJson(String source) =>
      FireModule.fromMap(json.decode(source));

  @override
  String toString() =>
      'FireModule(id: $id, name: $name, isCompleted: $isCompleted)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FireModule &&
        other.id == id &&
        other.name == name &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isCompleted.hashCode;
}
