class TodoEntity {
  final int id;
  final String description;
  final DateTime? date;
  final TodoPriority priority;
  final bool isCompleted;

  TodoEntity({
    required this.id,
    required this.description,
    required this.date,
    required this.priority,
    required this.isCompleted,
  });
}

enum TodoPriority {
  no(1),
  low(2),
  high(3);

  final int priority;

  const TodoPriority(this.priority);

  static TodoPriority fromLevel(int priority) {
    return TodoPriority.values.firstWhere((e) => e.priority == priority,
        orElse: () => throw ArgumentError('Invalid level: $priority'));
  }
}
