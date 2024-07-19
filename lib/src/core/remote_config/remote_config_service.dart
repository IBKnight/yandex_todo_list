import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:yandex_todo_list/src/core/data/rest_client.dart';
import 'package:yandex_todo_list/src/core/database/ilocal_storage.dart';
import 'package:yandex_todo_list/src/core/remote_config/entity/importance_color_entity.dart';
import 'package:yandex_todo_list/src/core/remote_config/models/importance_color_model.dart';
import 'package:yandex_todo_list/src/core/utils/logger.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig firebaseRemoteConfig;
  final ILocalStorage localStorage;
  final RestClient restClient;

  RemoteConfigService({
    required this.firebaseRemoteConfig,
    required this.localStorage,
    required this.restClient,
  });

  static const String _colorKey = 'importance_color';

  Stream<ImportanceColorEntity> get changeStream =>
      firebaseRemoteConfig.onConfigUpdated
          .asyncMap<ImportanceColorEntity>((value) async {
        try {
          if (value.updatedKeys.contains(_colorKey)) {
            await firebaseRemoteConfig.activate();

            final json = jsonDecode(
              firebaseRemoteConfig.getString(_colorKey),
            );

            final entity = ImportanceColorEntity(
              color: ImportanceColorModel.fromJson(json).color,
            );

            return entity;
          }
        } catch (e, stack) {
          logger.error(e, stackTrace: stack);
        }
        return const ImportanceColorEntity(color: '');
      });
}
