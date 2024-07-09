abstract interface class ILocalStorage {
  Future<Map<String, Object?>> getTodoList();
  Future<Map<String, Object?>> addTodo(Map<String, Object?> todo);
  Future<Map<String, Object?>> deleteTodo(String id);
  Future<Map<String, Object?>> getTodo(String id);
}
