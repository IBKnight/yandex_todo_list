part of 'network_status_bloc.dart';

@immutable
sealed class NetworkStatusEvent {}

class NetworkStatusObserve extends NetworkStatusEvent {}

class NetworkStatusNotify extends NetworkStatusEvent {
  final bool isConnected;

  NetworkStatusNotify({this.isConnected = false});
}
