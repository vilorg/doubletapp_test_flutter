// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'habbit_model.g.dart';

@HiveType(typeId: 0)
class HabbitModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final Priorety priority;
  @HiveField(3)
  final TypeHabbit type;
  @HiveField(4)
  final int count;
  @HiveField(5)
  final int date;
  @HiveField(6)
  final List<int> doneDates;
  @HiveField(7)
  final int frequency;
  @HiveField(8)
  final String uid;

  HabbitModel({
    required this.title,
    required this.description,
    required this.priority,
    required this.type,
    required this.count,
    required this.date,
    required this.doneDates,
    required this.frequency,
    required this.uid,
  });

  HabbitModel copyWith({
    String? title,
    String? description,
    Priorety? priority,
    TypeHabbit? type,
    int? count,
    int? date,
    List<int>? doneDates,
    int? frequency,
    String? uid,
  }) {
    return HabbitModel(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      type: type ?? this.type,
      count: count ?? this.count,
      date: date ?? this.date,
      doneDates: doneDates ?? this.doneDates,
      frequency: frequency ?? this.frequency,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'title': title,
      'description': description,
      'priority': priority.index,
      'type': type.index,
      'count': count,
      'date': date,
      'frequency': frequency,
    };
    if (uid != "") {
      map.addAll({'uid': uid});
    }
    debugPrint(map.toString());
    return map;
  }

  factory HabbitModel.fromMap(Map<String, dynamic> map) {
    return HabbitModel(
      title: map['title'] as String,
      description: map['description'] as String,
      priority: Priorety.values
          .firstWhere((element) => element.index == map['priority']),
      type: TypeHabbit.values
          .firstWhere((element) => element.index == map['type']),
      count: map['count'] as int,
      date: map['date'] as int,
      doneDates: List<int>.from((map['done_dates'].cast<int>() as List<int>)),
      frequency: map['frequency'] as int,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HabbitModel.fromJson(String source) =>
      HabbitModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  Future<void> save() async {}

  @override
  Future<void> delete() async {}

  @override
  String toString() {
    return 'HabbitModel(title: $title, description: $description, priority: $priority, type: $type, count: $count, date: $date, doneDates: $doneDates, frequency: $frequency, uid: $uid)';
  }

  @override
  bool operator ==(covariant HabbitModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.priority == priority &&
        other.type == type &&
        other.count == count &&
        other.date == date &&
        other.frequency == frequency &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        priority.hashCode ^
        type.hashCode ^
        count.hashCode ^
        date.hashCode ^
        doneDates.hashCode ^
        frequency.hashCode ^
        uid.hashCode;
  }
}

@HiveType(typeId: 1)
enum Priorety {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high
}

@HiveType(typeId: 2)
enum TypeHabbit {
  @HiveField(0)
  bad,
  @HiveField(1)
  good
}
