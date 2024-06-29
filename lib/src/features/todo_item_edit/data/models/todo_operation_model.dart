// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/models/todo_item/todo_model.dart';

part 'todo_operation_model.freezed.dart';
part 'todo_operation_model.g.dart';

@freezed
class TodoOperationModel with _$TodoOperationModel {
  const factory TodoOperationModel({
    @JsonKey(name: 'element') required TodoModel element,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'revision') required int revision,
  }) = _TodoOperationModel;

  factory TodoOperationModel.fromJson(Map<String, dynamic> json) =>
      _$TodoOperationModelFromJson(json);
}
