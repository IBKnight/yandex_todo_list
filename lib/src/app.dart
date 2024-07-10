import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/core/localization/localization.dart';
import 'package:yandex_todo_list/src/core/router/router.dart';
import 'common/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ToDo List',
      localizationsDelegates: Localization.localizationDelegates,
      supportedLocales: Localization.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: AppRouter.goRouter,
    );
  }
}
