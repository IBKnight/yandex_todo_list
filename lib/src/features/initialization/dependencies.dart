import 'package:yandex_todo_list/src/features/todos_list/bloc/todo_list_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/todo_list_repo_impl.dart';

base class Dependencies {
  const Dependencies(this.todoListBloc, this.repository);

  final TodoListBloc todoListBloc;
  final TodoListRepository repository;
}
