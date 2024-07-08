import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo_list/src/app.dart';
import 'package:yandex_todo_list/src/core/data/dio_client.dart';
import 'package:yandex_todo_list/src/core/database/database.dart';
import 'package:yandex_todo_list/src/core/utils/app_bloc_observer.dart';
import 'package:yandex_todo_list/src/core/utils/logger.dart';
import 'package:yandex_todo_list/src/features/initialization/dependencies.dart';
import 'package:yandex_todo_list/src/features/initialization/widgets/failed_init_screen.dart';
import 'package:yandex_todo_list/src/features/todos_list/bloc/todo_list_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/todo_list_repo_impl.dart';

final class AppRunner {
  const AppRunner();

  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    binding.deferFirstFrame();

    FlutterError.onError = logger.logFlutterError;
    WidgetsBinding.instance.platformDispatcher.onError =
        logger.logPlatformDispatcherError;

    Bloc.observer = AppBlocObserver(logger);
    Bloc.transformer = sequential();

    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: const String.fromEnvironment('BASE_URL'),
          headers: {
            'Authorization':
                'Bearer ${const String.fromEnvironment('APP_TOKEN')}',
          },
        ),
      );

      final dbService = DbService();

      final dioClient = DioClient(dio: dio);

      final todoListRepo = TodoListRepository(dbService, dioClient: dioClient);

      final TodoListBloc todoListBloc = TodoListBloc(todoListRepo);

      final dependencies = Dependencies(todoListBloc, todoListRepo);

      runApp(App(dependencies: dependencies));
    } catch (e, stackTrace) {
      logger.error('Initialization failed', error: e, stackTrace: stackTrace);

      runApp(const FailedInitScreen());
    } finally {
      binding.allowFirstFrame();
    }
  }
}
