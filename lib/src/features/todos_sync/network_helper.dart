import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:yandex_todo_list/src/features/todos_sync/bloc/network_status_bloc.dart';

class NetworkHelper {
  
  static void observeNetwork() {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.last == ConnectivityResult.none) {
        NetworkStatusBloc().add(NetworkStatusNotify());
      } else {
        NetworkStatusBloc().add(NetworkStatusNotify(isConnected: true));
      }
    });
  }
}
