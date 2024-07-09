import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yandex_todo_list/src/features/initialization/dependencies.dart';

class DependenciesScope extends InheritedWidget {
  const DependenciesScope({
    required this.dependencies,
    required super.child,
    super.key,
  });

  final Dependencies dependencies;

  static DependenciesScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DependenciesScope>()!;
  }

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) => false;
}
