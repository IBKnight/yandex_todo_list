import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo_list/src/core/utils/logger.dart';

/// [BlocObserver] логирует все стейты, ивенты и ошибки
class AppBlocObserver extends BlocObserver {

  const AppBlocObserver(this.logger);


  final Logger logger;

  @override
  void onTransition(
    Bloc<Object?, Object?> bloc,
    Transition<Object?, Object?> transition,
  ) {
    final logMessage = StringBuffer()
      ..writeln('Bloc: ${bloc.runtimeType}')
      ..writeln('Event: ${transition.event.runtimeType}')
      ..writeln('Transition: ${transition.currentState.runtimeType} => '
          '${transition.nextState.runtimeType}')
      ..write('New State: ${transition.nextState.toString()}');

    logger.info(logMessage.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc<Object?, Object?> bloc, Object? event) {
    final logMessage = StringBuffer()
      ..writeln('Bloc: ${bloc.runtimeType}')
      ..writeln('Event: ${event.runtimeType}')
      ..write('Details: ${event.toString()}');

    logger.info(logMessage.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase<Object?> bloc, Object error, StackTrace stackTrace) {
    final logMessage = StringBuffer()
      ..writeln('Bloc: ${bloc.runtimeType}')
      ..writeln(error.toString());

    logger.error(
      logMessage.toString(),
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
