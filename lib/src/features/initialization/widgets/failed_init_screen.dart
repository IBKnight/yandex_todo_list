import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/common/app_theme.dart';
import 'package:yandex_todo_list/src/core/localization/gen/app_localizations.dart';
import 'package:yandex_todo_list/src/core/localization/localization.dart';

class FailedInitScreen extends StatelessWidget {
  const FailedInitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      localizationsDelegates: Localization.localizationDelegates,
      supportedLocales: Localization.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.initFail,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          },
        ),
      ),
    );
  }
}
