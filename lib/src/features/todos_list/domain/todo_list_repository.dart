import 'package:yandex_todo_list/src/features/todo_item_edit/domain/entities/todo_operation_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';

import 'entities/todo_list/todo_list_entity.dart';

abstract interface class ITodoListRepository {
  Future<TodoListEntity> getTodoList();

  Future<TodoOperationEntity> getTodo(String id);

  Future<TodoOperationEntity> addTodo(
    TodoEntity todo,
    int revision,
  );

  Future<TodoOperationEntity> changeTodo(
    String id,
    TodoEntity todo,
    int revision,
  );

  Future<TodoOperationEntity> deleteTodo(String id, int revision);

  Future<TodoListEntity> updateTodoList(
    TodoListEntity todoList,
  );
}
