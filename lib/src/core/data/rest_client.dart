abstract class RestClient {
  Future<Map<String, Object?>?> getTodoList(
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

  /// Request body
  /// ```json
  /// {
  ///    "element": {
  ///         "color": "<hex color>",
  ///         "importance": <"low"|"basic"|"important">,
  ///         "done": <bool>,
  ///         "created_at": <timestamp>,
  ///         "id": "<uuid>",
  ///         "text": "some text",
  ///         "changed_at": <timestamp>,
  ///         "deadline": <timestamp>,
  ///         "last_updated_by": "123"
  ///     }
  /// }
  /// ```
  ///
  /// Header
  /// ```
  /// "X-Last-Known-Revision": <current revision>
  /// ```
  Future<Map<String, Object?>?> addTodo(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  });

  /// Request body
  /// ```json
  /// {
  ///    "element": {
  ///         "color": "<hex color>",
  ///         "importance": <"low"|"basic"|"important">,
  ///         "done": <bool>,
  ///         "created_at": <timestamp>,
  ///         "id": "<uuid>",
  ///         "text": "some text",
  ///         "changed_at": <timestamp>,
  ///         "deadline": <timestamp>,
  ///         "last_updated_by": "123"
  ///     }
  /// }
  /// ```
  ///
  /// Header
  /// ```
  /// "X-Last-Known-Revision": <current revision>
  /// ```
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

  /// Request body
  /// ```json
  /// {
  /// "list": [
  ///     {
  ///         "color": "<hex color>",
  ///         "importance": <"low"|"basic"|"important">,
  ///         "done": <bool>,
  ///         "created_at": <timestamp>,
  ///         "id": "<uuid>",
  ///         "text": "some text",
  ///         "changed_at": <timestamp>,
  ///         "deadline": <timestamp>,
  ///         "last_updated_by": "123"
  ///     },
  ///     ...
  /// ]
  /// }
  /// ```
  ///
  /// header
  /// ```
  /// "X-Last-Known-Revision": <current revision>
  /// ```
  Future<Map<String, Object?>?> updateTodoList(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  });
}
