import 'dart:convert';

import 'package:flutter/material.dart';

class BarChartModel {
  final int id;
  final String name;
  final double y;
  final Color color;
  BarChartModel({
    required this.id,
    required this.name,
    required this.y,
    required this.color,
  });

  BarChartModel copyWith({
    int? id,
    String? name,
    double? y,
    Color? color,
  }) {
    return BarChartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      y: y ?? this.y,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'y': y,
      'color': color.value,
    };
  }

  factory BarChartModel.fromMap(Map<String, dynamic> map) {
    return BarChartModel(
      id: map['id'],
      name: map['name'],
      y: map['y'],
      color: Color(map['color']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BarChartModel.fromJson(String source) =>
      BarChartModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BarChartModel(id: $id, name: $name, y: $y, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BarChartModel &&
        other.id == id &&
        other.name == name &&
        other.y == y &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ y.hashCode ^ color.hashCode;
  }
}
