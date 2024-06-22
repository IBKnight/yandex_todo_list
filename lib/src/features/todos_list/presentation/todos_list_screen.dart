import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yandex_todo_list/src/common/palette.dart';
import 'package:yandex_todo_list/src/common/strings.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/presentation/todo_item_edit_screen.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/todo_entity.dart';
import 'package:yandex_todo_list/src/features/todos_list/presentation/widgets/todo_appbar.dart';
import 'package:yandex_todo_list/src/features/todos_list/presentation/widgets/todo_tile.dart';

class TodosListScreen extends StatefulWidget {
  const TodosListScreen({super.key});

  @override
  State<TodosListScreen> createState() => _TodosListScreenState();
}

class _TodosListScreenState extends State<TodosListScreen> {
  //? Mock todos
  final List<TodoEntity> mockList = List.generate(20, (index) {
    final random = Random();

    const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

    String text = List.generate(
      random.nextInt(100) + 1,
      (index) => chars[random.nextInt(chars.length)],
    ).join();

    List<String> priorities = ['low', 'basic', 'important'];

    int randomIndex = random.nextInt(priorities.length);
    String randomPriority = priorities[randomIndex];

    int rangeInDays = 2;

    int secondsInDay = 24 * 60 * 60;

    int randomSeconds = random.nextInt(2 * rangeInDays * secondsInDay + 1) -
        rangeInDays * secondsInDay;

    return TodoEntity(
      id: const Uuid().v4(),
      text: text,
      importance: randomPriority,
      deadline: randomSeconds,
      done: random.nextBool(),
      color: null,
      createdAt: randomSeconds,
      changedAt: randomSeconds,
      lastUpdatedBy: random.nextInt(100) + 1,
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
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                    color: const Color(0xFF000000).withOpacity(0.12),
                  ),
                ],
              ),
              sliver: SliverPadding(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
                sliver: SliverList.builder(
                  itemCount: mockList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == mockList.length) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 50,
                        minTileHeight: 48,
                        leading: const SizedBox(),
                        title: Text(
                          Strings.newTodos,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TodoItemEditScreen(),
                            ),
                          );
                        },
                      );
                    }
                    return TodoTile(item: mockList[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TodoItemEditScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
