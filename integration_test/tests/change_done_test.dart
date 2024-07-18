import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:uuid/v4.dart';
import 'package:yandex_todo_list/src/app.dart';
import 'package:yandex_todo_list/src/core/data/dio_client.dart';
import 'package:yandex_todo_list/src/core/database/db_service.dart';
import 'package:yandex_todo_list/src/core/remote_config/remote_config_service.dart';
import 'package:yandex_todo_list/src/features/initialization/dependencies.dart';
import 'package:yandex_todo_list/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yandex_todo_list/src/features/todos_list/blocs/color_r_conf_bloc/color_remote_config_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_list/blocs/todo_list_bloc/todo_list_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/todo_list_repo_impl.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';
import 'package:yandex_todo_list/src/features/todos_sync/bloc/network_status_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_sync/data/sync_service.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  Firebase.initializeApp();
  const baseUrl = String.fromEnvironment('BASE_URL');
  const token = String.fromEnvironment('APP_TOKEN');
  final id = const UuidV4().generate();

  group('Интеграционный тест на смену состояния Todo', () {
    late Dependencies dependencies;
    late TodoListRepository repository;

    setUp(() async {
      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final dbService = DbService();
      final dioClient = DioClient(dio: dio);
      repository = TodoListRepository(
        dbService: dbService,
        restClient: dioClient,
      );
      final syncService = SyncService(
        restClient: dioClient,
        localStorage: dbService,
      );

      final TodoListBloc todoListBloc = TodoListBloc(repository);
      final Connectivity connectivity = Connectivity();
      final NetworkStatusBloc networkStatusBloc = NetworkStatusBloc(
        connectivity: connectivity,
        syncService: syncService,
      );

      final firebaseRemoteConfig = FirebaseRemoteConfig.instance;

      final RemoteConfigService remoteConfigService = RemoteConfigService(
        firebaseRemoteConfig: firebaseRemoteConfig,
        localStorage: dbService,
        restClient: dioClient,
      );

      final ColorRemoteConfigBloc colorRemoteConfigBloc = ColorRemoteConfigBloc(
        remoteConfigService: remoteConfigService,
      );

      dependencies = Dependencies(
        todoListBloc: todoListBloc,
        todoListRepo: repository,
        networkStatusBloc: networkStatusBloc,
        colorRemoteConfigBloc: colorRemoteConfigBloc,
      );

      // Создаем тестовую задачу и добавляем ее через репозиторий
      final list = await repository.getTodoList();
      final revision = list.revision;

      final todoEntity = TodoEntity(
        id: id,
        text: 'Купить молоко',
        importance: TodoImportance.basic,
        deadline: null,
        done: false,
        color: null,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        changedAt: DateTime.now().millisecondsSinceEpoch,
        lastUpdatedBy: 'testuser',
      );

      await repository.addTodo(todoEntity, revision);
    });

    testWidgets(
      'Пользователь меняет состояние задачи на выполнено/не выполнено',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          DependenciesScope(
            dependencies: dependencies,
            child: const App(),
          ),
        );

        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Находим виджет задачи в списке
        final checkboxFinder = find.byKey(ValueKey('checkbox_$id'));

        // Проверяем, что найден
        expect(checkboxFinder, findsOneWidget);

        var checkbox = tester.widget<Checkbox>(checkboxFinder);
        expect(checkbox.value, false);

        // Имитируем тап по чекбоксу
        await tester.tap(checkboxFinder);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Проверяем, что состояние задачи изменилось в репозитории
        final updatedTodo = await repository.getTodo(id);
        // Проверяем, что задача отмечена как выполненная
        expect(updatedTodo.element.done, true);
      },
      skip: false,
      timeout: const Timeout(
        Duration(minutes: 10),
      ),
    );
  });
}
