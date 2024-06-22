import 'dart:convert';

import 'package:yandex_todo_list/src/common/strings.dart';

TodoEntity todoEntityFromJson(String str) =>
    TodoEntity.fromJson(json.decode(str));

String todoEntityToJson(TodoEntity data) => json.encode(data.toJson());

/// [createdAt] & [changedAt] & [deadline] - timestamps
/// [id] stored uuid
/// [lastUpdatedBy] - device_id
class TodoEntity {
  final String id;
  final String text;
  final String importance;
  final int? deadline;
  final bool done;
  final String? color;
  final int createdAt;
  final int changedAt;
  //device_id
  final int lastUpdatedBy;

  TodoEntity({
    required this.id,
    required this.text,
    required this.importance,
    required this.deadline,
    required this.done,
    required this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  TodoEntity copyWith({
    String? id,
    String? text,
    String? importance,
    int? deadline,
    bool? done,
    String? color,
    int? createdAt,
    int? changedAt,
    int? lastUpdatedBy,
  }) =>
      TodoEntity(
        id: id ?? this.id,
        text: text ?? this.text,
        importance: importance ?? this.importance,
        deadline: deadline ?? this.deadline,
        done: done ?? this.done,
        color: color ?? this.color,
        createdAt: createdAt ?? this.createdAt,
        changedAt: changedAt ?? this.changedAt,
        lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
      );

  factory TodoEntity.fromJson(Map<String, dynamic> json) => TodoEntity(
        id: json['id'],
        text: json['text'],
        importance: json['importance'],
        deadline: json['deadline'],
        done: json['done'],
        color: json['color'],
        createdAt: json['created_at'],
        changedAt: json['changed_at'],
        lastUpdatedBy: json['last_updated_by'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'importance': importance,
        'deadline': deadline,
        'done': done,
        'color': color,
        'created_at': createdAt,
        'changed_at': changedAt,
        'last_updated_by': lastUpdatedBy,
      };
}

enum TodoImportance {
  basic(Strings.basic, 'basic'),
  low(Strings.low, 'low'),
  important(Strings.important, 'important');

  const TodoImportance(this.title, this.importance);
  final String importance;
  final String title;
}
