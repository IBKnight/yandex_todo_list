import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/core/localization/localization.dart';
import 'package:yandex_todo_list/src/features/initialization/dependencies.dart';
import 'package:yandex_todo_list/src/features/initialization/widgets/dependencies_scope.dart';
import 'package:yandex_todo_list/src/features/todos_list/presentation/widgets/todo_list_provider.dart';
import 'common/app_theme.dart';

class App extends StatelessWidget {
  final Dependencies dependencies;
  const App({super.key, required this.dependencies});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      localizationsDelegates: Localization.localizationDelegates,
      supportedLocales: Localization.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: DependenciesScope(
        dependencies: dependencies,
        child: const TodoListProvider(),
      ),
    );
  }
}
