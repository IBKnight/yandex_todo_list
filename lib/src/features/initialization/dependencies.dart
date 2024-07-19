import 'package:yandex_todo_list/src/features/todos_list/blocs/color_r_conf_bloc/color_remote_config_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_list/blocs/todo_list_bloc/todo_list_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/todo_list_repo_impl.dart';
import 'package:yandex_todo_list/src/features/todos_sync/bloc/network_status_bloc.dart';

base class Dependencies {
  const Dependencies({
    required this.todoListBloc,
    required this.todoListRepo,
    required this.networkStatusBloc,
    required this.colorRemoteConfigBloc,
  });

  final TodoListBloc todoListBloc;
  final TodoListRepository todoListRepo;
  final NetworkStatusBloc networkStatusBloc;
  final ColorRemoteConfigBloc colorRemoteConfigBloc;
}
