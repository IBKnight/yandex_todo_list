part of 'network_status_bloc.dart';

@immutable
sealed class NetworkStatusState {}

class NetworkStatusLoading extends NetworkStatusState {}

class NetworkStatusSuccess extends NetworkStatusState {}

class NetworkStatusFailure extends NetworkStatusState {}
