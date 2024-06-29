// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';

part 'todo_list_entity.freezed.dart';

@freezed
class TodoListEntity with _$TodoListEntity {
  const factory TodoListEntity({
    required String status,
    required List<TodoEntity> list,
    required int revision,
  }) = _TodoListEntity;
}
