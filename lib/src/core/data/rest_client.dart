abstract class RestClient {
  Future<Map<String, Object?>?> getList(
    String path, {
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  });
  Future<Map<String, Object?>?> getTodo(
    String path,
    String uuid, {
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  });

  Future<Map<String, Object?>?> addTodo(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  });

  Future<Map<String, Object?>?> changeTodo(
    String path,
    String uuid, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  });

  Future<Map<String, Object?>?> deleteTodo(
    String path,
    String uuid, {
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  });

  Future<Map<String, Object?>?> updateList(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  });
}
