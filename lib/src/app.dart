import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/common/app_theme.dart';
import 'package:yandex_todo_list/src/features/todos_list/presentation/todos_list_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const TodosListScreen(),
    );
  }
}
