// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';

part 'todo_operation_entity.freezed.dart';

@freezed
class TodoOperationEntity with _$TodoOperationEntity {
  const factory TodoOperationEntity({
    required TodoEntity element,
    required String status,
    required int revision,
  }) = _TodoOperationEntity;
}
