abstract interface class ILocalStorage {
  Future<Map<String, Object?>> getTodoList();

  Future<Map<String, Object?>> addTodo(Map<String, Object?> todo);

  Future<Map<String, Object?>> deleteTodo(String id);

  Future<Map<String, Object?>> getTodo(String id);

  Future<Map<String, Object?>> updateTodo(Map<String, Object?> todo);

  Future<Map<String, Object?>> updateTodoList(Map<String, dynamic> data);

  Future<int> getRevision();

  Future<void> setRevision(int revision);
}
