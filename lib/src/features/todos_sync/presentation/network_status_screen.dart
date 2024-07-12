import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_list/presentation/todos_list_screen.dart';
import 'package:yandex_todo_list/src/features/todos_sync/bloc/network_status_bloc.dart';

class NetworkStatusScreen extends StatelessWidget {
  const NetworkStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NetworkStatusBloc, NetworkStatusState>(
        builder: (context, state) {
          if (state is NetworkStatusLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const TodosListScreen();
        },
      ),
    );
  }
}
