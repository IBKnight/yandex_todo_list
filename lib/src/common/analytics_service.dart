import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:yandex_todo_list/src/core/utils/logger.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';

class AnalyticsService {
  const AnalyticsService._();

  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static FirebaseAnalytics get analytics => _analytics;

  static void sendAddEvent(TodoEntity todo) {
    try {
      _analytics.logEvent(
        name: 'add_task',
        parameters: {},
      );
    } catch (e) {
      logger.error(e.toString());
    }
  }

  static void sendDeleteEvent(TodoEntity todo) {
    try {
      _analytics.logEvent(
        name: 'delete_task',
        parameters: {},
      );
    } catch (e) {
      logger.error(e.toString());
    }
  }

  static void sendUpdateEvent(TodoEntity todo) {
    try {
      _analytics.logEvent(
        name: 'update_task',
        parameters: {},
      );
    } catch (e) {
      logger.error(e.toString());
    }
  }
}
