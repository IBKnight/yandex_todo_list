import 'dart:async';
import 'package:yandex_todo_list/src/features/initialization/app_runner.dart';

import 'src/core/utils/logger.dart';

void main() {
  logger.runLogging(
    () => runZonedGuarded(
      () async {
        const AppRunner().initializeAndRun();
      },
      logger.logZoneError,
    ),
  );
}
//? Просто лучший тутор на ютубе на тему Zone
//? и как с их помощью хэндлить ошибки:
//? https://www.youtube.com/watch?v=dQw4w9WgXcQ
