import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_todo_list/src/core/localization/gen/app_localizations.dart';
import 'package:yandex_todo_list/src/features/todos_list/bloc/todo_list_bloc.dart';
import '../../../common/palette.dart';
import '../../todo_item_edit/presentation/todo_item_edit_screen.dart';
import 'widgets/todo_appbar.dart';
import 'widgets/todo_tile.dart';

class TodosListScreen extends StatefulWidget {
  const TodosListScreen({super.key});

  @override
  State<TodosListScreen> createState() => _TodosListScreenState();
}

class _TodosListScreenState extends State<TodosListScreen> {
  bool _shownCompleted = false;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<TodoListBloc, TodoListState>(
        builder: (context, state) {
          return switch (state) {
            TodoListLoading _ => const Center(
                child: CircularProgressIndicator(),
              ),
            TodoListLoaded _ => CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: TodoSliverPersistentDelegate(
                      showCompleted: () {
                        setState(() {
                          _shownCompleted = !_shownCompleted;
                        });
                      },
                      completedCount: state.todoListEntity.list
                          .where((todo) => todo.done)
                          .length,
                      shownCompleted: _shownCompleted,
                    ),
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
                            color: Palette.shadowColor.withOpacity(0.06),
                          ),
                          BoxShadow(
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                            color: Palette.shadowColor.withOpacity(0.12),
                          ),
                        ],
                      ),
                      sliver: SliverPadding(
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 8),
                        sliver: SliverList.builder(
                          itemCount: _shownCompleted
                              ? state.todoListEntity.list.length + 1
                              : state.todoListEntity.list
                                      .where((todo) => !todo.done)
                                      .toList()
                                      .length +
                                  1,
                          itemBuilder: (context, index) {
                            final todos = _shownCompleted
                                ? state.todoListEntity.list
                                : state.todoListEntity.list
                                    .where((todo) => !todo.done)
                                    .toList();
                            if (index == todos.length) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                minLeadingWidth: 50,
                                minTileHeight: 48,
                                leading: const SizedBox(),
                                title: Text(
                                  locale.newTodos,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: Palette.labelTertiaryLight,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                        value: BlocProvider.of<TodoListBloc>(
                                          context,
                                        ),
                                        child: const TodoItemEditScreen(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return TodoTile(
                              key: Key(todos[index].id),
                              item: todos[index],
                              showCompleted: _shownCompleted,
                              markDone: () => context.read<TodoListBloc>().add(
                                    TodoListChange(
                                      listEntity: state.todoListEntity,
                                      todoEntity:
                                          todos[index].copyWith(done: true),
                                    ),
                                  ),
                              delete: () {
                                context.read<TodoListBloc>().add(
                                      TodoListDelete(
                                        listEntity: state.todoListEntity,
                                        id: todos[index].id,
                                      ),
                                    );
                              },
                              checkboxCallback: (bool isChecked) {
                                context.read<TodoListBloc>().add(
                                      TodoListChange(
                                        listEntity: state.todoListEntity,
                                        todoEntity: todos[index]
                                            .copyWith(done: isChecked),
                                      ),
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
            TodoListError _ => Center(child: Text(state.message)),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(
            '/add',
            extra: BlocProvider.of<TodoListBloc>(context),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
