import 'package:yandex_todo_list/src/features/todo_item_edit/data/models/todo_operation_model.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/domain/entities/todo_operation_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/mappers/todo_mapper.dart';

class TodoOperationMapper {
  static TodoOperationEntity toEntity(TodoOperationModel model) {
    return TodoOperationEntity(
      element: TodoMapper.toEntity(model.element),
      status: model.status,
      revision: model.revision,
    );
  }

  static TodoOperationModel toModel(TodoOperationEntity entity) {
    return TodoOperationModel(
      element: TodoMapper.toModel(entity.element),
      status: entity.status,
      revision: entity.revision,
    );
  }
}
