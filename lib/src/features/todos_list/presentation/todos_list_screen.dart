import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/common/strings.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/todo_entity.dart';

class TodosListScreen extends StatefulWidget {
  const TodosListScreen({super.key});

  @override
  State<TodosListScreen> createState() => _TodosListScreenState();
}

class _TodosListScreenState extends State<TodosListScreen> {
  final List<TodoEntity> mockList = List.generate(20, (index) {
    final random = Random();

    List<TodoPriority> priorities = TodoPriority.values;

    int randomIndex = random.nextInt(priorities.length);
    TodoPriority randomPriority = priorities[randomIndex];

    return TodoEntity(
      id: index,
      description: (pow(index, 5)).hashCode.toString() * 25,
      date: DateTime(2025),
      priority: randomPriority,
      isCompleted: random.nextBool(),
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F2),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Color(0xFFF7F6F2),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(Strings.myTodos),
            ),
          ),
          const SliverToBoxAdapter(
            child: Row(
              children: [Text('вы')],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
            sliver: DecoratedSliver(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: const Color(0xFF000000).withOpacity(0.06),
                  ),
                  BoxShadow(
                    offset: const Offset(0, 2),
                    color: const Color(0xFF000000).withOpacity(0.06),
                  )
                ],
              ),
              sliver: SliverList.builder(
                itemCount: mockList.length + 1,
                itemBuilder: (context, index) {
                  // TodoEntity item = mockList[index];
                  if (index == mockList.length) {
                    return Text(Strings.newTodos);
                  }
                  return ListTile(
                    title: Text(
                      mockList[index].description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle:
                        mockList[index].date != null ? const Text(Strings.date) : null,
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Text(Strings.newTodos),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
