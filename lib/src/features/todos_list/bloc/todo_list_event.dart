part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListEvent {}

final class TodoListLoad extends TodoListEvent {}

final class TodoListDelete extends TodoListEvent {
  final TodoListEntity listEntity;
  final String id;

  TodoListDelete({required this.listEntity, required this.id});
}

final class TodoListAdd extends TodoListEvent {
  final TodoListEntity listEntity;
  final TodoEntity todoEntity;

  TodoListAdd({required this.listEntity, required this.todoEntity});
}

final class TodoListChange extends TodoListEvent {
  final TodoListEntity listEntity;
  final TodoEntity todoEntity;

  TodoListChange({
    required this.listEntity,
    required this.todoEntity,
  });
}
