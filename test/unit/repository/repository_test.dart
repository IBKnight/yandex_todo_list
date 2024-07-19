import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yandex_todo_list/src/core/data/dio_client.dart';
import 'package:yandex_todo_list/src/core/database/db_service.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/data/models/todo_operation_model.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/domain/entities/todo_operation_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/models/todo_item/todo_model.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/models/todo_list/todo_list_model.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/todo_list_repo_impl.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_list/todo_list_entity.dart';

@GenerateNiceMocks([MockSpec<DioClient>(), MockSpec<DbService>()])
import 'repository_test.mocks.dart';

void main() {
  late TodoListRepository repository;
  late MockDioClient mockRestClient;
  late MockDbService mockLocalStorage;

  setUp(() {
    mockRestClient = MockDioClient();
    mockLocalStorage = MockDbService();
    repository = TodoListRepository(
      restClient: mockRestClient,
      dbService: mockLocalStorage,
    );
  });

  group('TodoListRepository', () {
    const todoModel = TodoModel(
      id: '1',
      text: 'Test',
      importance: TodoImportance.low,
      deadline: null,
      done: false,
      color: null,
      createdAt: 1627580800,
      changedAt: 1627580800,
      lastUpdatedBy: 'user1',
    );

    const todoEntity = TodoEntity(
      id: '1',
      text: 'Test',
      importance: TodoImportance.low,
      deadline: null,
      done: false,
      color: null,
      createdAt: 1627580800,
      changedAt: 1627580800,
      lastUpdatedBy: 'user1',
    );

    const todoOperationModel = TodoOperationModel(
      element: todoModel,
      status: 'ok',
      revision: 1,
    );

    const todoOperationEntity = TodoOperationEntity(
      element: todoEntity,
      status: 'ok',
      revision: 1,
    );

    const todoListModel = TodoListModel(
      status: 'ok',
      list: [todoModel],
      revision: 1,
    );

    const todoListEntity = TodoListEntity(
      status: 'ok',
      list: [todoEntity],
      revision: 1,
    );

    test('добавить Todo', () async {
      when(
        mockRestClient.addTodo(
          any,
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => todoOperationModel.toJson());

      when(mockLocalStorage.addTodo(any))
          .thenAnswer((_) async => todoModel.toJson());
      when(mockLocalStorage.getRevision()).thenAnswer((_) async => 1);

      final result = await repository.addTodo(
        todoEntity,
        1,
      );

      expect(result, todoOperationEntity);
      verify(
        mockRestClient.addTodo(
          any,
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).called(1);
    });

    test('изменить Todo', () async {
      when(
        mockRestClient.changeTodo(
          any,
          any,
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => todoOperationModel.toJson());

      when(mockLocalStorage.updateTodo(any))
          .thenAnswer((_) async => todoModel.toJson());
      when(mockLocalStorage.getRevision()).thenAnswer((_) async => 1);

      final result = await repository.changeTodo(
        '1',
        todoEntity,
        1,
      );

      expect(result, todoOperationEntity);
      verify(
        mockRestClient.changeTodo(
          any,
          any,
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).called(1);
    });

    test('удалить Todo', () async {
      when(mockRestClient.deleteTodo(any, any, headers: anyNamed('headers')))
          .thenAnswer((_) async => todoOperationModel.toJson());

      when(mockLocalStorage.deleteTodo(any))
          .thenAnswer((_) async => todoModel.toJson());
      when(mockLocalStorage.getRevision()).thenAnswer((_) async => 1);

      final result = await repository.deleteTodo(
        '1',
        1,
      );

      expect(result, todoOperationEntity);
      verify(mockRestClient.deleteTodo(any, any, headers: anyNamed('headers')))
          .called(1);
    });

    test('получить Todo', () async {
      when(mockRestClient.getTodo(any, any))
          .thenAnswer((_) async => todoOperationModel.toJson());

      final result = await repository.getTodo(
        '1',
      );

      expect(result, todoOperationEntity);
      verify(mockRestClient.getTodo(any, any)).called(1);
    });

    test('получить TodoList', () async {
      when(mockRestClient.getTodoList(any))
          .thenAnswer((_) async => todoListModel.toJson());
      when(mockLocalStorage.updateTodoList(any)).thenAnswer((_) async => {});

      final result = await repository.getTodoList();

      expect(result, todoListEntity);
      verify(mockRestClient.getTodoList(any)).called(1);
    });

    test('обновить TodoList', () async {
      when(
        mockRestClient.addTodo(
          any,
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => todoListModel.toJson());

      final result = await repository.updateTodoList(
        todoListEntity,
      );

      expect(result, todoListEntity);
      verify(
        mockRestClient.addTodo(
          any,
          body: anyNamed('body'),
          headers: anyNamed('headers'),
        ),
      ).called(1);
    });
  });
}
