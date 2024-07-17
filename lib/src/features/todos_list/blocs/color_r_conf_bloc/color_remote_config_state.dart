part of 'color_remote_config_bloc.dart';

@immutable
sealed class ColorRemoteConfigState {}

final class ColorRemoteConfigLoading extends ColorRemoteConfigState {}

final class ColorRemoteConfigLoaded extends ColorRemoteConfigState {
  final String? color;

  ColorRemoteConfigLoaded({required this.color});
}

final class ColorRemoteConfigError extends ColorRemoteConfigState {}
