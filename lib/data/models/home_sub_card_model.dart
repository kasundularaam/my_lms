import 'dart:convert';

class HomeSubCard {
  String name;
  int modules;
  int contents;
  int quiz;
  int completdModules;
  int completedContents;
  int completedQuiz;
  HomeSubCard({
    required this.name,
    required this.modules,
    required this.contents,
    required this.quiz,
    required this.completdModules,
    required this.completedContents,
    required this.completedQuiz,
  });

  HomeSubCard copyWith({
    String? name,
    int? modules,
    int? contents,
    int? quiz,
    int? completdModules,
    int? completedContents,
    int? completedQuiz,
  }) {
    return HomeSubCard(
      name: name ?? this.name,
      modules: modules ?? this.modules,
      contents: contents ?? this.contents,
      quiz: quiz ?? this.quiz,
      completdModules: completdModules ?? this.completdModules,
      completedContents: completedContents ?? this.completedContents,
      completedQuiz: completedQuiz ?? this.completedQuiz,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'modules': modules,
      'contents': contents,
      'quiz': quiz,
      'completdModules': completdModules,
      'completedContents': completedContents,
      'completedQuiz': completedQuiz,
    };
  }

  factory HomeSubCard.fromMap(Map<String, dynamic> map) {
    return HomeSubCard(
      name: map['name'],
      modules: map['modules'],
      contents: map['contents'],
      quiz: map['quiz'],
      completdModules: map['completdModules'],
      completedContents: map['completedContents'],
      completedQuiz: map['completedQuiz'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeSubCard.fromJson(String source) =>
      HomeSubCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeSubCard(name: $name, modules: $modules, contents: $contents, quiz: $quiz, completdModules: $completdModules, completedContents: $completedContents, completedQuiz: $completedQuiz)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeSubCard &&
        other.name == name &&
        other.modules == modules &&
        other.contents == contents &&
        other.quiz == quiz &&
        other.completdModules == completdModules &&
        other.completedContents == completedContents &&
        other.completedQuiz == completedQuiz;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        modules.hashCode ^
        contents.hashCode ^
        quiz.hashCode ^
        completdModules.hashCode ^
        completedContents.hashCode ^
        completedQuiz.hashCode;
  }
}
