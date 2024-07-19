part of 'network_status_bloc.dart';

@immutable
sealed class NetworkStatusEvent {}

class NetworkStatusChanged extends NetworkStatusEvent {
  final bool isConnected;

  NetworkStatusChanged({this.isConnected = false});
}
