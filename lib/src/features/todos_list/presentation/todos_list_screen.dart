import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/common/palette.dart';
import 'package:yandex_todo_list/src/common/strings.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/presentation/todo_item_edit_screen.dart';
import 'package:yandex_todo_list/src/features/todos_list/presentation/todo_list_notifier.dart';
import 'package:yandex_todo_list/src/features/todos_list/presentation/widgets/todo_appbar.dart';
import 'package:yandex_todo_list/src/features/todos_list/presentation/widgets/todo_tile.dart';

class TodosListScreen extends StatefulWidget {
  const TodosListScreen({super.key});

  @override
  State<TodosListScreen> createState() => _TodosListScreenState();
}

class _TodosListScreenState extends State<TodosListScreen> {
  late TodoListModel _todoListModel;

  @override
  void initState() {
    super.initState();
    _todoListModel = TodoListModel();
    _todoListModel.generateMockTodos(20);
  }

  @override
  void dispose() {
    _todoListModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backPrimaryLight,
      body: CustomScrollView(
        slivers: [
          ListenableBuilder(
            listenable: _todoListModel,
            builder: (context, _) {
              return SliverPersistentHeader(
                delegate: TodoSliverPersistentDelegate(
                  showCompleted: _todoListModel.toggleShowCompleted,
                  completedCount: _todoListModel.completedCount,
                  shownCompleted: _todoListModel.showCompleted,
                ),
                pinned: true,
                floating: false,
              );
            },
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
                sliver: ListenableBuilder(
                  listenable: _todoListModel,
                  builder: (context, _) {
                    final todos = _todoListModel.todos;

                    return SliverList.builder(
                      itemCount: todos.length + 1,
                      itemBuilder: (context, index) {
                        if (index == todos.length) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            minLeadingWidth: 50,
                            minTileHeight: 48,
                            leading: const SizedBox(),
                            title: Text(
                              Strings.newTodos,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Palette.labelTertiaryLight),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TodoItemEditScreen(),
                                ),
                              );
                            },
                          );
                        }
                        return TodoTile(
                          key: Key(todos[index].id.toString()),
                          item: todos[index],
                          markDone: () =>
                              _todoListModel.markTodoDone(todos[index]),
                          delete: () => _todoListModel.deleteTodo(todos[index]),
                          checkboxCallback: (bool isChecked) {
                            _todoListModel.checkboxTodo(
                              todos[index],
                              isChecked,
                            );
                          },
                        );
                      },
                    );
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
