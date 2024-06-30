import 'package:yandex_todo_list/src/features/todos_list/data/models/todo_item/todo_model.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';

class TodoMapper {
  static TodoEntity toEntity(TodoModel model) {
    return TodoEntity(
      id: model.id,
      text: model.text,
      importance: model.importance,
      deadline: model.deadline,
      done: model.done,
      color: model.color,
      createdAt: model.createdAt,
      changedAt: model.changedAt,
      lastUpdatedBy: model.lastUpdatedBy,
    );
  }

  static TodoModel toModel(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      text: entity.text,
      importance: entity.importance,
      deadline: entity.deadline,
      done: entity.done,
      color: entity.color,
      createdAt: entity.createdAt,
      changedAt: entity.changedAt,
      lastUpdatedBy: entity.lastUpdatedBy,
    );
  }
}