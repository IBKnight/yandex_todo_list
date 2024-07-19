import 'package:dio/dio.dart';
import 'package:yandex_todo_list/src/core/data/exceptions/network_exception.dart';
import 'package:yandex_todo_list/src/core/data/rest_client.dart';
import 'package:yandex_todo_list/src/core/database/ilocal_storage.dart';
import 'package:yandex_todo_list/src/core/utils/logger.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/data/mappers/todo_operation_mapper.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/data/models/todo_operation_model.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/domain/entities/todo_operation_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/mappers/todo_list_mapper.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/mappers/todo_mapper.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/models/todo_item/todo_model.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/models/todo_list/todo_list_model.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_list/todo_list_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/todo_list_repository.dart';

class TodoListRepository implements ITodoListRepository {
  final RestClient _restClient;
  final ILocalStorage _dbService;

  TodoListRepository({
    required RestClient restClient,
    required ILocalStorage dbService,
  })  : _restClient = restClient,
        _dbService = dbService;

  final endpoint = '/list';

  @override
  Future<TodoOperationEntity> addTodo(
    TodoEntity todo,
    int revision,
  ) async {
    TodoOperationEntity? entity;

    try {
      final todoMap = TodoMapper.toModel(todo).toJson();

      final result = await _restClient.addTodo(
        endpoint,
        body: {'element': todoMap},
        headers: {
          'X-Last-Known-Revision': revision,
        },
      );

      final TodoOperationModel model =
          TodoOperationModel.fromJson(result ?? {});

      return TodoOperationMapper.toEntity(model);
    } on DioException catch (e) {
      if (e.type != DioExceptionType.connectionError) {
        int statusCode = e.response?.statusCode ?? 500;
        throw NetworkException(statusCode: statusCode);
      }
    } catch (e, stackTrace) {
      logger.error('', error: e, stackTrace: stackTrace);
    } finally {
      final todoMap = TodoMapper.toModel(todo).toJson();

      final todoEntity = TodoMapper.toEntity(
        TodoModel.fromJson(
          await _dbService.addTodo(todoMap),
        ),
      );

      entity = TodoOperationEntity(
        element: todoEntity,
        status: 'ok',
        revision: await _dbService.getRevision(),
      );
    }
    return entity;
  }

  @override
  Future<TodoOperationEntity> changeTodo(
    String id,
    TodoEntity todo,
    int revision,
  ) async {
    TodoOperationEntity? entity;

    try {
      final todoMap = TodoMapper.toModel(todo).toJson();

      final result = await _restClient.changeTodo(
        endpoint,
        todo.id,
        body: {'element': todoMap},
        headers: {
          'X-Last-Known-Revision': revision,
        },
      );

      final TodoOperationModel model =
          TodoOperationModel.fromJson(result ?? {});

      entity = TodoOperationMapper.toEntity(model);

      return entity;
    } on DioException catch (e) {
      if (e.type != DioExceptionType.connectionError) {
        int statusCode = e.response?.statusCode ?? 500;
        throw NetworkException(statusCode: statusCode);
      }
    } catch (e, stackTrace) {
      logger.error('', error: e, stackTrace: stackTrace);
    } finally {
      final todoMap = TodoMapper.toModel(todo).toJson();

      final todoEntity = TodoMapper.toEntity(
        TodoModel.fromJson(
          await _dbService.updateTodo(todoMap),
        ),
      );

      entity = TodoOperationEntity(
        element: todoEntity,
        status: 'ok',
        revision: await _dbService.getRevision(),
      );
    }
    return entity;
  }

  @override
  Future<TodoOperationEntity> deleteTodo(String id, int revision) async {
    TodoOperationEntity? entity;

    try {
      final result = await _restClient.deleteTodo(
        endpoint,
        id,
        headers: {
          'X-Last-Known-Revision': revision,
        },
      );

      final TodoOperationModel model =
          TodoOperationModel.fromJson(result ?? {});

      return TodoOperationMapper.toEntity(model);
    } on DioException catch (e) {
      if (e.type != DioExceptionType.connectionError) {
        int statusCode = e.response?.statusCode ?? 500;
        throw NetworkException(statusCode: statusCode);
      }
    } catch (e, stackTrace) {
      logger.error('', error: e, stackTrace: stackTrace);
    } finally {
      final todoEntity = TodoMapper.toEntity(
        TodoModel.fromJson(
          await _dbService.deleteTodo(id),
        ),
      );

      entity = TodoOperationEntity(
        element: todoEntity,
        status: 'ok',
        revision: await _dbService.getRevision(),
      );
    }
    return entity;
  }

  @override
  Future<TodoOperationEntity> getTodo(String id) async {
    try {
      final model = TodoOperationModel.fromJson(
        await _restClient.getTodo(endpoint, id) ?? {},
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
      final jsonResponse = await _restClient.getTodoList(endpoint) ?? {};

      final model = TodoListModel.fromJson(jsonResponse);

      await _dbService.updateTodoList(jsonResponse);

      return TodoListMapper.toEntity(model);
    } catch (e) {
      final json = await _dbService.getTodoList();

      final model = TodoListModel.fromJson(json);

      return TodoListMapper.toEntity(model);
    }
  }

  @override
  Future<TodoListEntity> updateTodoList(
    TodoListEntity todoList,
  ) async {
    try {
      final todoMap = TodoListMapper.toModel(todoList).toJson();

      final result = await _restClient.addTodo(
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
