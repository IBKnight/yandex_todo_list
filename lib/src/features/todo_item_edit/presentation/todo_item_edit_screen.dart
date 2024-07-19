import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:yandex_todo_list/src/common/palette.dart';
import 'package:yandex_todo_list/src/common/theme/theme_extensions/brand_colors_theme_ex.dart';
import 'package:yandex_todo_list/src/core/localization/gen/app_localizations.dart';
import 'package:yandex_todo_list/src/core/router/router.dart';
import 'package:yandex_todo_list/src/features/todos_list/blocs/todo_list_bloc/todo_list_bloc.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';

part 'package:yandex_todo_list/src/features/todo_item_edit/presentation/widgets/description_text_field.dart';

class TodoItemEditScreen extends StatefulWidget {
  const TodoItemEditScreen({super.key, this.id});

  final String? id;

  @override
  State<TodoItemEditScreen> createState() => _TodoItemEditScreenState();
}

class _TodoItemEditScreenState extends State<TodoItemEditScreen> {
  TodoImportance _selectedImportance = TodoImportance.basic;
  DateTime? _dateTime;
  bool _hasDeadline = false;
  late final TextEditingController _textEditingController =
      TextEditingController();

  TodoEntity? todoEntity;

  @override
  void initState() {
    _getElement();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final brandColors = theme.extension<BrandColors>()!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          splashRadius: 22,
          onPressed: () => AppRouter.backTo(),
          icon: Icon(
            Icons.close,
            size: 22,
            color: brandColors.labelPrimary,
          ),
        ),
        scrolledUnderElevation: 5,
        actions: [
          TextButton(
            onPressed: () {
              _saveButtonPress(context);
            },
            child: Text(
              strings.save,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: brandColors.blue,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            _DescriptionTextField(
              textEditingController: _textEditingController,
            ),
            const SizedBox(height: 12),
            ListTile(
              minTileHeight: 72,
              contentPadding:
                  const EdgeInsetsDirectional.symmetric(horizontal: 16),
              minLeadingWidth: 0,
              title: Text(
                strings.priority,
                style: theme.textTheme.bodyLarge,
              ),
              subtitle: PopupMenuButton<TodoImportance>(
                initialValue: _selectedImportance,
                onSelected: _popMenuSelect,
                itemBuilder: (BuildContext context) => TodoImportance.values
                    .map<PopupMenuEntry<TodoImportance>>(
                        (TodoImportance importance) {
                  return PopupMenuItem<TodoImportance>(
                    value: importance,
                    child: Text(
                      _fromImportance(item: importance, strings: strings),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: importance == TodoImportance.important
                            ? brandColors.red
                            : brandColors.labelTertiary,
                      ),
                    ),
                  );
                }).toList(),
                child: Text(
                  _fromImportance(item: _selectedImportance, strings: strings),
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: brandColors.labelTertiary),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
              child: Divider(),
            ),
            ListTile(
              minTileHeight: 72,
              contentPadding:
                  const EdgeInsetsDirectional.symmetric(horizontal: 16),
              minLeadingWidth: 0,
              title: Text(
                strings.doUpTo,
                style: theme.textTheme.bodyLarge,
              ),
              subtitle: _dateTime != null
                  ? Text(
                      DateFormat.yMMMMd(strings.localeName).format(
                        _dateTime!,
                      ),
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: brandColors.blue),
                    )
                  : null,
              trailing: Switch(
                value: _hasDeadline,
                onChanged: _switchChange,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            ListTile(
              onTap: _deletePress,
              enabled: todoEntity != null,
              minTileHeight: 48,
              minLeadingWidth: 0,
              titleAlignment: ListTileTitleAlignment.center,
              leading: Icon(
                Icons.delete,
                color: todoEntity != null
                    ? brandColors.red
                    : brandColors.labelDisable,
              ),
              title: Text(
                strings.delete,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: todoEntity != null
                      ? brandColors.red
                      : brandColors.labelDisable,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getElement() {
    // Получаем стейт загруженных элементов
    final state = BlocProvider.of<TodoListBloc>(context).state;

    if (state is TodoListLoaded) {
      //Ищем по айди элемент в списке
      final entities = state.todoListEntity.list
          .where((entity) => entity.id == widget.id)
          .toList();

      if (entities.isNotEmpty) {
        todoEntity = entities.first;

        _textEditingController.text = todoEntity?.text ?? '';
        _selectedImportance = TodoImportance.values
            .where(
              (importance) => importance == todoEntity?.importance,
            )
            .first;
        _dateTime = todoEntity?.deadline == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(
                todoEntity?.deadline ?? DateTime.now().millisecondsSinceEpoch,
              );
      } else {
        todoEntity = null;
      }
    } else {
      todoEntity = null;
    }

    _hasDeadline = _dateTime != null;
  }

  void _switchChange(value) async {
    if (!_hasDeadline) {
      final date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
      );
      setState(() {
        _dateTime = date;
        _hasDeadline = _dateTime != null;
      });
    } else {
      setState(() {
        _hasDeadline = false;
        _dateTime = null;
      });
    }
  }

  void _popMenuSelect(TodoImportance item) {
    setState(() {
      _selectedImportance = item;
    });
  }

  String _fromImportance({
    required TodoImportance item,
    required AppLocalizations strings,
  }) {
    switch (item) {
      case TodoImportance.low:
        return strings.low;
      case TodoImportance.basic:
        return strings.basic;
      case TodoImportance.important:
        return strings.important;
    }
  }

  void _saveButtonPress(BuildContext context) {
    final item = todoEntity;
    final state = BlocProvider.of<TodoListBloc>(context).state;

    if (state is! TodoListLoaded) {
      return AppRouter.backTo();
    }

    if (item == null) {
      context.read<TodoListBloc>().add(
            TodoListAdd(
              listEntity: state.todoListEntity,
              todoEntity: TodoEntity(
                id: const Uuid().v4(),
                text: _textEditingController.text,
                importance: _selectedImportance,
                deadline: _dateTime?.millisecondsSinceEpoch,
                done: false,
                createdAt: DateTime.now().millisecondsSinceEpoch,
                changedAt: DateTime.now().millisecondsSinceEpoch,
                lastUpdatedBy: '1',
              ),
            ),
          );
    } else {
      context.read<TodoListBloc>().add(
            TodoListChange(
              listEntity: state.todoListEntity,
              todoEntity: TodoEntity(
                id: item.id,
                text: _textEditingController.text,
                importance: _selectedImportance,
                deadline: _dateTime?.millisecondsSinceEpoch,
                done: item.done,
                createdAt: item.createdAt,
                changedAt: DateTime.now().millisecondsSinceEpoch,
                lastUpdatedBy: item.lastUpdatedBy,
              ),
            ),
          );
    }
    AppRouter.backTo();
  }

  void _deletePress() {
    final item = todoEntity;
    final state = BlocProvider.of<TodoListBloc>(context).state;

    if (state is! TodoListLoaded) {
      return AppRouter.backTo();
    }

    if (item != null) {
      context.read<TodoListBloc>().add(
            TodoListDelete(
              listEntity: state.todoListEntity,
              id: item.id,
            ),
          );
    }
    AppRouter.backTo();
  }
}
