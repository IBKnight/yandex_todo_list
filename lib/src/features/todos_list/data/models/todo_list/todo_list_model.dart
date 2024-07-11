// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/models/todo_item/todo_model.dart';

part 'todo_list_model.freezed.dart';
part 'todo_list_model.g.dart';

@freezed
class TodoListModel with _$TodoListModel {
  @JsonSerializable(explicitToJson: true)
  const factory TodoListModel({
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'list') required List<TodoModel> list,
    @JsonKey(name: 'revision') required int revision,
  }) = _TodoListModel;

  factory TodoListModel.fromJson(Map<String, Object?> json) =>
      _$TodoListModelFromJson(json);
}
