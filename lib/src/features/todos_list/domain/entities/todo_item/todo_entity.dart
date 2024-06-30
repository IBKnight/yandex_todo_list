import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_entity.freezed.dart';

/// [createdAt] & [changedAt] & [deadline] - timestamps
/// [id] stored uuid
/// [lastUpdatedBy] - device_id
@freezed
class TodoEntity with _$TodoEntity {
  const factory TodoEntity({
    required String id,
    required String text,
    required TodoImportance importance,
    int? deadline,
    required bool done,
    String? color,
    required int createdAt,
    required int changedAt,
    required String lastUpdatedBy,
  }) = _TodoEntity;
}

enum TodoImportance {
  @JsonValue('basic')
  basic('basic'),
  @JsonValue('low')
  low('low'),
  @JsonValue('important')
  important('important');

  const TodoImportance(this.importance);
  final String importance;

  static TodoImportance fromString(String importance) {
    switch (importance) {
      case 'low':
        return TodoImportance.low;
      case 'important':
        return TodoImportance.important;
      case 'basic':
      default:
        return TodoImportance.basic;
    }
  }
}
