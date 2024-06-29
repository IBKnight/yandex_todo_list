// ignore_for_file: prefer_single_quotes
// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/core/logger.dart';

void main() {
  logger.runLogging(
    () => runZonedGuarded(
      () async {

        runApp(const App());
      },
      logger.logZoneError,
    ),
  );
}
//? Просто лучший тутор на ютубе на тему Zone
//? и как с их помощью хэндлить ошибки:
//? https://www.youtube.com/watch?v=dQw4w9WgXcQ


//TODO: !!!
        // String a = const String.fromEnvironment('BASE_URL');
        // String token = const String.fromEnvironment('TOKEN');
