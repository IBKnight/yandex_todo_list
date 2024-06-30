import 'package:yandex_todo_list/src/core/data/dio_client.dart';
import 'package:yandex_todo_list/src/core/database/database.dart';
import 'package:yandex_todo_list/src/core/utils/logger.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/data/mappers/todo_operation_mapper.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/data/models/todo_operation_model.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/domain/entities/todo_operation_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/mappers/todo_list_mapper.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/mappers/todo_mapper.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/models/todo_list/todo_list_model.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_list/todo_list_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/todo_list_repository.dart';

class TodoListRepository implements ITodoListRepository {
  final DioClient _dioClient;
  final DbService _dbService;

  TodoListRepository(
    this._dbService, {
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  final endpoint = '/list';

  @override
  Future<TodoOperationEntity> addTodo(
    TodoEntity todo,
    int revision,
  ) async {
    try {
      final todoMap = TodoMapper.toModel(todo).toJson();

      final result = await _dioClient.addTodo(
        endpoint,
        body: {'element': todoMap},
        headers: {
          'X-Last-Known-Revision': revision,
        },
      );

      final TodoOperationModel model =
          TodoOperationModel.fromJson(result ?? {});

      return TodoOperationMapper.toEntity(model);
    } catch (e, stackTrace) {
      logger.error('', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<TodoOperationEntity> changeTodo(
    String id,
    TodoEntity todo,
    int revision,
  ) async {
    try {
      final todoMap = TodoMapper.toModel(todo).toJson();

      final result = await _dioClient.changeTodo(
        endpoint,
        todo.id,
        body: {'element': todoMap},
        headers: {
          'X-Last-Known-Revision': revision,
        },
      );

      final TodoOperationModel model =
          TodoOperationModel.fromJson(result ?? {});

      return TodoOperationMapper.toEntity(model);
    } catch (e, stackTrace) {
      logger.error('', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<TodoOperationEntity> deleteTodo(String id, int revision) async {
    try {
      final result = await _dioClient.deleteTodo(
        endpoint,
        id,
        headers: {
          'X-Last-Known-Revision': revision,
        },
      );

      final TodoOperationModel model =
          TodoOperationModel.fromJson(result ?? {});

      return TodoOperationMapper.toEntity(model);
    } catch (e, stackTrace) {
      logger.error('', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<TodoOperationEntity> getTodo(String id) async {
    try {
      final model = TodoOperationModel.fromJson(
        await _dioClient.getTodo(endpoint, id) ?? {},
      );

      return TodoOperationMapper.toEntity(model);
    } catch (e, stackTrace) {
      logger.error('', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<TodoListEntity> getTodoList() async {
    try {
      final jsonResponse = await _dioClient.getList(endpoint) ?? {};

      final model = TodoListModel.fromJson(jsonResponse);

      await _dbService.updateDatabase(jsonResponse);

      return TodoListMapper.toEntity(model);
    } catch (e, stackTrace) {
      logger.error('', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<TodoListEntity> updateTodoList(
    String id,
    TodoListEntity todoList,
  ) async {
    try {
      final todoMap = TodoListMapper.toModel(todoList).toJson();

      final result = await _dioClient.addTodo(
        endpoint,
        body: {'list': todoMap['list']},
        headers: {
          'X-Last-Known-Revision': todoList.revision,
        },
      );

      final TodoListModel model = TodoListModel.fromJson(result ?? {});

      return TodoListMapper.toEntity(model);
    } catch (e, stackTrace) {
      logger.error('', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
