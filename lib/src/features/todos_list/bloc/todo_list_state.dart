part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListState extends Equatable {}

final class TodoListLoading extends TodoListState {
  @override
  List<Object?> get props => [];
}

final class TodoListLoaded extends TodoListState {
  final TodoListEntity todoListEntity;

  TodoListLoaded({required this.todoListEntity});
  @override
  List<Object?> get props => [todoListEntity];
}

final class TodoListError extends TodoListState {
  final String message;
  final TodoListEntity todoListEntity;
  final NetworkExceptionStatus status;

  TodoListError({
    required this.message,
    required this.todoListEntity,
    required this.status,
  });

  @override
  List<Object?> get props => [message, todoListEntity];
}
