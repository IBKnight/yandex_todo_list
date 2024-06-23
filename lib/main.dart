import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/app.dart';
import 'package:yandex_todo_list/src/core/logger.dart';

void main() {
  logger.runLogging(
    () => runZonedGuarded(
      () {
        runApp(const App());
      },
      logger.logZoneError,
    ),
  );
}
//? Просто лучший тутор на ютубе на тему Zone
//? и как с их помощью хэндлить ошибки:
//? https://www.youtube.com/watch?v=dQw4w9WgXcQ