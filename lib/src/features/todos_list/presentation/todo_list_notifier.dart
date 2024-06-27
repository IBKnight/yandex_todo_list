import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../domain/entities/todo_entity.dart';

/// Временное решение на [ChangeNotifier]
/// и [ListenableBuilder] в остуствии нормальной бизнес логики

class TodoListModel extends ChangeNotifier {
  List<TodoEntity> _todos = [];
  bool _showCompleted = false;

  List<TodoEntity> get todos =>
      _showCompleted ? _todos : _todos.where((todo) => !todo.done).toList();

  int get completedCount => _todos.where((todo) => todo.done).length;

  bool get showCompleted => _showCompleted;

  void generateMockTodos(int count) {
    _todos = List.generate(count, (index) {
      final random = Random();
      const String chars =
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

      String text = List.generate(
        random.nextInt(100) + 1,
        (index) => chars[random.nextInt(chars.length)],
      ).join();

      List<String> priorities = ['low', 'basic', 'important'];
      String randomPriority = priorities[random.nextInt(priorities.length)];

      const int rangeInDays = 365;
      const int secondsInDay = 24 * 60 * 60;
      const int millisecondsInDay = secondsInDay * 100;

      final DateTime startOf2024 = DateTime(2024, 1, 1);
      final int startOf2024InMilliseconds = startOf2024.millisecondsSinceEpoch;

      final int randomMilliseconds = startOf2024InMilliseconds +
          random.nextInt(rangeInDays * millisecondsInDay);

      final int? dateOrNull = random.nextBool() ? randomMilliseconds : null;

      return TodoEntity(
        id: const Uuid().v4(),
        text: text,
        importance: TodoImportance.fromString(randomPriority),
        deadline: dateOrNull,
        done: random.nextBool(),
        color: null,
        createdAt: randomMilliseconds,
        changedAt: randomMilliseconds,
        lastUpdatedBy: random.nextInt(100) + 1,
      );
    });
    notifyListeners();
  }

  void toggleShowCompleted() {
    _showCompleted = !_showCompleted;
    notifyListeners();
  }

  void markTodoDone(TodoEntity todo) {
    final index = _todos.indexOf(todo);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(done: true);
      notifyListeners();
    }
  }

  void checkboxTodo(TodoEntity todo, bool value) {
    final index = _todos.indexOf(todo);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(done: value);
      notifyListeners();
    }
  }

  void deleteTodo(TodoEntity todo) {
    _todos.remove(todo);
    notifyListeners();
  }
}
