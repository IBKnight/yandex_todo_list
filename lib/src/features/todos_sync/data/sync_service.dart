import 'package:yandex_todo_list/src/core/data/rest_client.dart';
import 'package:yandex_todo_list/src/core/database/ilocal_storage.dart';
import 'package:yandex_todo_list/src/core/utils/logger.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/models/todo_list/todo_list_model.dart';

class SyncService {
  final RestClient restClient;
  final ILocalStorage localStorage;

  SyncService({required this.restClient, required this.localStorage});

//TODO (IBKnight): Сделать нормальный синк
  Future<void> servicesSync() async {
    try {
      int localRevision = await localStorage.getRevision();
      final todoListModel =
          TodoListModel.fromJson(await restClient.getTodoList('/list') ?? {});
      int remoteRevision = todoListModel.revision;

      if (localRevision > remoteRevision) {
        final todosLocal = await localStorage.getTodoList();
        final todosRemote = TodoListModel.fromJson(
          await restClient.updateTodoList(
                '/list',
                body: {'list': todosLocal['list']},
                headers: {
                  'X-Last-Known-Revision': remoteRevision,
                },
              ) ??
              {},
        );
        localStorage.setRevision(todosRemote.revision);
      } else {
        final jsonResponse = await restClient.getTodoList('/list') ?? {};
        await localStorage.updateTodoList(jsonResponse);
      }
    } catch (e) {
      logger.error(e);
      rethrow;
    }
  }
}
