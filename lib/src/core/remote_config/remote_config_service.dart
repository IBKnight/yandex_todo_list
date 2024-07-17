import 'dart:convert';
import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:yandex_todo_list/src/core/data/rest_client.dart';
import 'package:yandex_todo_list/src/core/database/ilocal_storage.dart';
import 'package:yandex_todo_list/src/core/remote_config/entity/importance_color_entity.dart';
import 'package:yandex_todo_list/src/core/remote_config/models/importance_color_model.dart';
import 'package:yandex_todo_list/src/core/utils/logger.dart';
import 'package:yandex_todo_list/src/features/todos_list/blocs/todo_list_bloc/todo_list_bloc.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig firebaseRemoteConfig;
  final ILocalStorage localStorage;
  final RestClient restClient;

  RemoteConfigService({
    required this.firebaseRemoteConfig,
    required this.localStorage,
    required this.restClient,
  });

  Stream<ImportanceColorEntity> get changeStream =>
      firebaseRemoteConfig.onConfigUpdated
          .asyncMap<ImportanceColorEntity>((value) async {
        try {
          if (value.updatedKeys.contains('color')) {
            // log('raw data ${value.updatedKeys}');

            final json = jsonDecode(
              firebaseRemoteConfig.getString('color'),
            );

            final entity = ImportanceColorEntity(
              color: ImportanceColorModel.fromJson(json).color,
            );

            await _updpateColors(entity.color);

            return entity;
          }
        } catch (e, stack) {
          logger.error(e, stackTrace: stack);
        }
        return const ImportanceColorEntity(color: '');
      });

//TODO переделать
  Future<void> _updpateColors(String? newColor) async {
    try {
      final response = await restClient.getTodoList('/list');

      final responseList = response?['list'] as List;

      final todoList = List<Map<String, Object?>>.from(responseList);

      // Обновляем цвет у всех задач с важностью 'high'
      for (var todo in todoList) {
        if (todo['importance'] == 'high') {
          todo['color'] = newColor;
        }
      }

      // Обновляем список задач в базе данных
      await localStorage.updateTodoList({
        'list': todoList,
        'revision': response?['revision'],
      });

      logger.info('Todos updated successfully');
    } catch (e) {
      logger.error('Failed to update todos', error: e);
      rethrow;
    }
  }
}
