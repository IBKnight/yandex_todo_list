import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yandex_todo_list/src/core/remote_config/remote_config_service.dart';
import 'package:yandex_todo_list/src/core/utils/logger.dart';

part 'color_remote_config_event.dart';
part 'color_remote_config_state.dart';

class ColorRemoteConfigBloc
    extends Bloc<ColorRemoteConfigEvent, ColorRemoteConfigState> {
  final RemoteConfigService remoteConfigService;

  // Без игнора аналайзер считает, что поле unused, хотя ниже оно используется
  // ignore: unused_field
  StreamSubscription? _remoteConfigSub;

  ColorRemoteConfigBloc({required this.remoteConfigService})
      : super(ColorRemoteConfigLoading()) {
    on<ColorRemoteConfigChange>((event, emit) => _changeColor(event, emit));

    _remoteConfigSub = remoteConfigService.changeStream.distinct().listen(
      (remoteConfigUpdate) {
        if (remoteConfigUpdate.color != null) {
          log('fsfsfdsfd');
          add(ColorRemoteConfigChange());
        }
      },
    );
  }

  void _changeColor(
    ColorRemoteConfigChange event,
    Emitter<ColorRemoteConfigState> emit,
  ) async {
    try {
      await emit.forEach(
        remoteConfigService.changeStream,
        onData: (entity) {
          return ColorRemoteConfigLoaded(color: entity.color);
        },
      );
    } catch (e) {
      logger.error(e);
      emit(ColorRemoteConfigError());
    }
  }

  @override
  Future<void> close() async {
    _remoteConfigSub?.cancel();
    super.close();
    _remoteConfigSub = null;
  }
}
