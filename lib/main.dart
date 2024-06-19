import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/app.dart';

void main() {
  runZonedGuarded(
    () {
      runApp(const App());
    },
    (error, stackTrace) => log('Error: $error, StackTrace: $stackTrace'),
  );
}
