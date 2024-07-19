import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:yandex_todo_list/firebase_options.dart';
import 'package:yandex_todo_list/src/features/initialization/app_runner.dart';

import 'src/core/utils/logger.dart';

void main() {
  logger.runLogging(
    () {
      return runZonedGuarded(() async {
        WidgetsFlutterBinding.ensureInitialized();

        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        const AppRunner().initializeAndRun();
      }, (error, stackTrace) {
        logger.logZoneError(error, stackTrace);
        FirebaseCrashlytics.instance
            .recordError(error, stackTrace);
      });
    },
  );
}
//? Просто лучший тутор на ютубе на тему Zone
//? и как с их помощью хэндлить ошибки:
//? https://www.youtube.com/watch?v=dQw4w9WgXcQ
