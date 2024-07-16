import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:yandex_todo_list/src/features/todos_sync/data/sync_service.dart';

part 'network_status_event.dart';
part 'network_status_state.dart';

class NetworkStatusBloc extends Bloc<NetworkStatusEvent, NetworkStatusState> {
  final SyncService syncService;
  final Connectivity connectivity;

  // Без игнора аналайзер считает, что поле unused, хотя ниже оно используется
  // ignore: unused_field
  StreamSubscription? _networkSub;

  NetworkStatusBloc({
    required this.syncService,
    required this.connectivity,
  }) : super(NetworkStatusLoading()) {
    on<NetworkStatusEvent>(
      (event, emit) => switch (event) {
        NetworkStatusChanged e => _notifyStatus(e, emit),
      },
    );

    _networkSub = connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      log(result.toString());
      if (result.last == ConnectivityResult.none) {
        add(NetworkStatusChanged());
      } else {
        add(NetworkStatusChanged(isConnected: true));
      }
    });
  }
  @override
  Future<void> close() async {
    _networkSub?.cancel();
    super.close();
    _networkSub = null;
  }

  void _notifyStatus(
    NetworkStatusChanged event,
    Emitter<NetworkStatusState> emit,
  ) async {
    try {
      if (event.isConnected) {
        emit(NetworkStatusLoading());

        await syncService.servicesSync();

        emit(NetworkStatusSuccess());
      } else {
        emit(
          NetworkStatusFailure(),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
