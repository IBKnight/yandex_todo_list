import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo_list/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yandex_todo_list/src/features/todos_list/bloc/todo_list_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_sync/presentation/network_status_screen.dart';

class TodoListProvider extends StatelessWidget {
  const TodoListProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = DependenciesScope.of(context).dependencies.todoListBloc;
    final networkBloc =
        DependenciesScope.of(context).dependencies.networkStatusBloc;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => bloc..add(TodoListLoad()),
        ),
        BlocProvider(
          create: (context) => networkBloc,
        ),
      ],
      child: const NetworkStatusScreen(),
    );
  }
}
