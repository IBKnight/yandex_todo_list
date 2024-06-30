import 'package:yandex_todo_list/src/features/todos_list/data/mappers/todo_mapper.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/models/todo_list/todo_list_model.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_list/todo_list_entity.dart';

class TodoListMapper {
  static TodoListEntity toEntity(TodoListModel model) {
    return TodoListEntity(
      status: model.status,
      list: model.list.map(TodoMapper.toEntity).toList(),
      revision: model.revision,
    );
  }

  static TodoListModel toModel(TodoListEntity entity) {
    return TodoListModel(
      status: entity.status,
      list: entity.list.map(TodoMapper.toModel).toList(),
      revision: entity.revision,
    );
  }
}
