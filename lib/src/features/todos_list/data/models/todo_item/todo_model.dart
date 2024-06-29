// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

/// [createdAt] & [changedAt] & [deadline] - timestamps
/// [id] stored uuid
/// [lastUpdatedBy] - device_id
@freezed
class TodoModel with _$TodoModel {
  const factory TodoModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'text') required String text,
    @JsonKey(name: 'importance') required TodoImportance importance,
    @JsonKey(name: 'deadline') int? deadline,
    @JsonKey(name: 'done') required bool done,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'created_at') required int createdAt,
    @JsonKey(name: 'changed_at') required int changedAt,
    @JsonKey(name: 'last_updated_by') required String lastUpdatedBy,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
}
