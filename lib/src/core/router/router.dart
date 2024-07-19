import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yandex_todo_list/src/common/analytics_service.dart';
import 'package:yandex_todo_list/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yandex_todo_list/src/features/todo_item_edit/presentation/todo_item_edit_screen.dart';
import 'package:yandex_todo_list/src/features/todos_list/presentation/widgets/todo_list_provider.dart';

enum RouteNames {
  initial(name: 'main_screen', route: '/'),
  add(name: 'add_screen', route: 'add'),
  edit(name: 'edit_screen', route: 'edit/:id');

  final String name;
  final String route;

  const RouteNames({required this.name, required this.route});
}

abstract class AppRouter {
  static final FirebaseAnalyticsObserver _observer = FirebaseAnalyticsObserver(
    analytics: AnalyticsService.analytics,
  );
  static final _goRouter = GoRouter(
    observers: [
      _observer,
    ],
    routes: [
      GoRoute(
        path: RouteNames.initial.route,
        name: RouteNames.initial.name,
        builder: (context, state) => const TodoListProvider(),
        routes: [
          GoRoute(
            path: RouteNames.add.route,
            name: RouteNames.add.name,
            builder: (context, state) => BlocProvider.value(
              value: DependenciesScope.of(context).dependencies.todoListBloc,
              child: const TodoItemEditScreen(),
            ),
          ),
          GoRoute(
            path: RouteNames.edit.route,
            name: RouteNames.edit.name,
            builder: (context, state) => BlocProvider.value(
              value: DependenciesScope.of(context).dependencies.todoListBloc,
              child: TodoItemEditScreen(id: state.pathParameters['id']),
            ),
          ),
        ],
      ),
    ],
    onException: (context, state, router) => const TodoListProvider(),
  );

  static GoRouter get goRouter => _goRouter;

  static void toAddScreen() {
    _goRouter.push('/add');
  }

  static void toEditScreen({required String id}) {
    _goRouter.push('/edit/$id');
  }

  static void backTo() {
    _goRouter.pop();
  }
}
