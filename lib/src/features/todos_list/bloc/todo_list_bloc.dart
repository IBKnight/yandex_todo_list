import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/domain/entities/todo_operation_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_list/todo_list_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/todo_list_repository.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final ITodoListRepository repository;
  TodoListBloc(this.repository) : super(TodoListLoading()) {
    on<TodoListEvent>(
      (event, emit) => switch (event) {
        TodoListLoad e => _loadTodoList(e, emit),
        TodoListDelete e => _deleteTodo(e, emit),
        TodoListAdd e => _addTodo(e, emit),
        TodoListChange e => _changeTodo(e, emit),
      },
      transformer: sequentialThrottle(),
    );
  }

  EventTransformer<Event> sequentialThrottle<Event>() {
    return (events, mapper) =>
        events.throttle(const Duration(milliseconds: 300)).asyncExpand(mapper);
  }

  Future<void> _addTodo(
    TodoListAdd event,
    Emitter<TodoListState> emit,
  ) async {
    try {
      final TodoOperationEntity newEntity = await repository.addTodo(
        event.todoEntity,
        event.listEntity.revision,
      );

      final List<TodoEntity> updatedListEntity =
          List<TodoEntity>.from(event.listEntity.list)..add(newEntity.element);

      final updatedList = event.listEntity.copyWith(
        list: updatedListEntity,
        revision: newEntity.revision,
      );

      emit(TodoListLoaded(updatedList));
    } catch (e) {
      emit(TodoListError(e.toString()));
    }
  }

  Future<void> _loadTodoList(
    TodoListLoad event,
    Emitter<TodoListState> emit,
  ) async {
    try {
      emit(TodoListLoading());
      final entity = await repository.getTodoList();
      emit(TodoListLoaded(entity));
    } catch (e) {
      emit(TodoListError(e.toString()));
    }
  }

  Future<void> _changeTodo(
    TodoListChange event,
    Emitter<TodoListState> emit,
  ) async {
    try {
      final TodoOperationEntity changedEntity = await repository.changeTodo(
        event.todoEntity.id,
        event.todoEntity,
        event.listEntity.revision,
      );

      // Копируем текущий listEntity
      final List<TodoEntity> updatedListEntity =
          List<TodoEntity>.from(event.listEntity.list);

      // Находим индекс элемента по id
      final index = updatedListEntity
          .indexWhere((todo) => todo.id == event.todoEntity.id);

      if (index != -1) {
        updatedListEntity[index] = changedEntity.element;
      }

      // Создаем новый listEntity с обновленным списком
      final updatedList = event.listEntity.copyWith(
        list: updatedListEntity,
        revision: changedEntity.revision,
      );

      emit(TodoListLoaded(updatedList));
    } catch (e) {
      emit(TodoListError(e.toString()));
    }
  }

  Future<void> _deleteTodo(
    TodoListDelete event,
    Emitter<TodoListState> emit,
  ) async {
    try {
      final TodoOperationEntity deletedEntity = await repository.deleteTodo(
        event.id,
        event.listEntity.revision,
      );

      final List<TodoEntity> updatedListEntity =
          List<TodoEntity>.from(event.listEntity.list);

      final index = updatedListEntity.indexWhere((todo) => todo.id == event.id);

      if (index != -1) {
        updatedListEntity.removeAt(index);
      }

      final updatedList = event.listEntity.copyWith(
        list: updatedListEntity,
        revision: deletedEntity.revision,
      );

      emit(TodoListLoaded(updatedList));
    } catch (e) {
      emit(TodoListError(e.toString()));
    }
  }
}
