import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/common/palette.dart';
import 'package:yandex_todo_list/src/common/strings.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/todo_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/presentation/widgets/todo_appbar.dart';

class TodosListScreen extends StatefulWidget {
  const TodosListScreen({super.key});

  @override
  State<TodosListScreen> createState() => _TodosListScreenState();
}

class _TodosListScreenState extends State<TodosListScreen>
    with SingleTickerProviderStateMixin {
  //? Mock todos
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
  //?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backPrimaryLight,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: TodoSliverPersistentDelegate(),
            pinned: true,
            floating: false,
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
                    return const Text(Strings.newTodos);
                  }
                  return ListTile(
                    title: Text(
                      mockList[index].description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: mockList[index].date != null
                        ? const Text(Strings.date)
                        : null,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
