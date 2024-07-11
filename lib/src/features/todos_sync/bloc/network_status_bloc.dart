import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yandex_todo_list/src/features/todos_sync/data/sync_service.dart';
import 'package:yandex_todo_list/src/features/todos_sync/network_helper.dart';

part 'network_status_event.dart';
part 'network_status_state.dart';

class NetworkStatusBloc extends Bloc<NetworkStatusEvent, NetworkStatusState> {
  final SyncService syncService;
  NetworkStatusBloc({required this.syncService})
      : super(NetworkStatusLoading()) {
    on<NetworkStatusEvent>(
      (event, emit) => switch (event) {
        NetworkStatusObserve e => _observe(e, emit),
        NetworkStatusNotify e => _notifyStatus(e, emit),
      },
    );
  }
  void _observe(NetworkStatusObserve event, Emitter<NetworkStatusState> emit) {
    NetworkHelper.observeNetwork();
  }

  void _notifyStatus(
    NetworkStatusNotify event,
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
