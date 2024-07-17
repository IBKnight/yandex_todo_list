import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo_list/src/common/palette.dart';
import 'package:yandex_todo_list/src/core/localization/gen/app_localizations.dart';
import 'package:yandex_todo_list/src/features/todos_list/presentation/todos_list_screen.dart';
import 'package:yandex_todo_list/src/features/todos_sync/bloc/network_status_bloc.dart';

class NetworkStatusScreen extends StatelessWidget {
  const NetworkStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      body: BlocConsumer<NetworkStatusBloc, NetworkStatusState>(
        listener: (context, state) {
          if (state is NetworkStatusSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Durations.long3,
                backgroundColor: Palette.greenLight,
                content: _SnackBarContent(
                  icon: Icons.cloud_done,
                  message: locale.onlineMode,
                ),
              ),
            );
          } else if (state is NetworkStatusFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Durations.long3,
                backgroundColor: Palette.colorGrayLight,
                content: _SnackBarContent(
                  icon: Icons.cloud_off,
                  message: locale.offlineMode,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is NetworkStatusLoading) {
            return const _ServerSyncLoading();
          }
          return const TodosListScreen();
        },
      ),
    );
  }
}

class _SnackBarContent extends StatelessWidget {
  const _SnackBarContent({
    required this.message,
    required this.icon,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Palette.colorWhiteLight,
        ),
        const SizedBox(width: 16),
        Text(
          message,
          style: theme.textTheme.titleMedium?.copyWith(
            color: Palette.colorWhiteLight,
          ),
        ),
      ],
    );
  }
}

class _ServerSyncLoading extends StatelessWidget {
  const _ServerSyncLoading();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.cloud_upload,
            size: 100,
          ),
          Text(
            locale.serverSync,
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
