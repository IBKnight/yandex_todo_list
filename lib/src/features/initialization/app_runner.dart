import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo_list/src/app.dart';
import 'package:yandex_todo_list/src/core/data/dio_client.dart';
import 'package:yandex_todo_list/src/core/database/db_service.dart';
import 'package:yandex_todo_list/src/core/remote_config/remote_config_service.dart';
import 'package:yandex_todo_list/src/core/utils/app_bloc_observer.dart';
import 'package:yandex_todo_list/src/core/utils/logger.dart';
import 'package:yandex_todo_list/src/features/initialization/dependencies.dart';
import 'package:yandex_todo_list/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yandex_todo_list/src/features/initialization/widgets/failed_init_screen.dart';
import 'package:yandex_todo_list/src/features/todos_list/blocs/color_r_conf_bloc/color_remote_config_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_list/blocs/todo_list_bloc/todo_list_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/todo_list_repo_impl.dart';
import 'package:yandex_todo_list/src/features/todos_sync/bloc/network_status_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_sync/data/sync_service.dart';

final class AppRunner {
  const AppRunner();

  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    binding.deferFirstFrame();

    FlutterError.onError = (errorDetails) {
      logger.logFlutterError(errorDetails);
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
      logger.logPlatformDispatcherError(error, stack);
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

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

      final todoListRepo = TodoListRepository(
        dbService: dbService,
        restClient: dioClient,
      );

      final TodoListBloc todoListBloc = TodoListBloc(todoListRepo);

      final syncService = SyncService(
        restClient: dioClient,
        localStorage: dbService,
      );

      final connectivity = Connectivity();

      final NetworkStatusBloc networkStatusBloc = NetworkStatusBloc(
        syncService: syncService,
        connectivity: connectivity,
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

      final dependencies = Dependencies(
        todoListBloc: todoListBloc,
        todoListRepo: todoListRepo,
        networkStatusBloc: networkStatusBloc,
        colorRemoteConfigBloc: colorRemoteConfigBloc,
      );

      runApp(
        DependenciesScope(
          dependencies: dependencies,
          child: const App(),
        ),
      );
    } catch (e, stackTrace) {
      logger.error('Initialization failed', error: e, stackTrace: stackTrace);

      runApp(const FailedInitScreen());
    } finally {
      binding.allowFirstFrame();
    }
  }
}
