import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/presentation/todo_item_edit_screen.dart';
import 'package:yandex_todo_list/src/features/todos_list/bloc/todo_list_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_list/presentation/widgets/todo_list_provider.dart';

abstract class AppRouter {
  static final _goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const TodoListProvider(),
        routes: [
          GoRoute(
            path: 'details/:id',
            builder: (context, state) => BlocProvider.value(
              value: state.extra! as TodoListBloc,
              child: TodoItemEditScreen(id: state.pathParameters['id']),
            ),
          ),
        ],
      ),
    ],
  );

  static GoRouter get goRouter => _goRouter;
}
