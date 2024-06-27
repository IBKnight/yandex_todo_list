import 'todo_entity.dart';

class TodoListEntity {
  final String status;
  final List<TodoEntity> list;
  final int revision;

  TodoListEntity({
    required this.status,
    required this.list,
    required this.revision,
  });

  TodoListEntity copyWith({
    String? status,
    List<TodoEntity>? list,
    int? revision,
  }) =>
      TodoListEntity(
        status: status ?? this.status,
        list: list ?? this.list,
        revision: revision ?? this.revision,
      );
// TODO: escape dynamic
  factory TodoListEntity.fromJson(Map<String, dynamic> json) => TodoListEntity(
        status: json['status'],
        list: List<TodoEntity>.from(
          json['list'].map((x) => TodoEntity.fromJson(x)),
        ),
        revision: json['revision'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'list': List<dynamic>.from(list.map((x) => x.toJson())),
        'revision': revision,
      };
}
