import 'package:flutter/material.dart';

import 'package:yandex_todo_list/src/common/palette.dart';
import 'package:yandex_todo_list/src/core/localization/gen/app_localizations.dart';
import 'package:yandex_todo_list/src/core/utils/extensions/date_time_extension.dart';

import 'package:yandex_todo_list/src/features/todos_list/domain/entities/todo_item/todo_entity.dart';
part 'package:yandex_todo_list/src/features/todo_item_edit/widgets/description_text_field.dart';

class TodoItemEditScreen extends StatefulWidget {
  const TodoItemEditScreen({super.key, this.todoEntity});

  final TodoEntity? todoEntity;

  @override
  State<TodoItemEditScreen> createState() => _TodoItemEditScreenState();
}

class _TodoItemEditScreenState extends State<TodoItemEditScreen> {
  TodoImportance _selectedImportance = TodoImportance.basic;
  DateTime? _dateTime;
  bool _hasDeadline = false;
  late final TextEditingController _textEditingController =
      TextEditingController();

  @override
  void initState() {
    final item = widget.todoEntity;
    if (item != null) {
      _textEditingController.text = item.text;
      _selectedImportance = TodoImportance.values
          .where(
            (importance) => importance == item.importance,
          )
          .first;
      _dateTime = item.deadline == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              item.deadline ?? DateTime.now().millisecondsSinceEpoch,
            );
    }

    _hasDeadline = _dateTime != null;

    super.initState();
  }

  void _switchChange(value) {
    if (!_hasDeadline) {
      showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
      ).then(
        (value) => setState(() {
          _dateTime = value;
          _hasDeadline = _dateTime != null;
        }),
      );
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

  String fromImportance(TodoImportance item, AppLocalizations strings) {
    switch (item) {
      case TodoImportance.low:
        return strings.low;
      case TodoImportance.basic:
        return strings.basic;
      case TodoImportance.important:
        return strings.important;
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Palette.backPrimaryLight,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          splashRadius: 22,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 22,
            color: Palette.labelPrimaryLight,
          ),
        ),
        scrolledUnderElevation: 5,
        backgroundColor: Palette.backPrimaryLight,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              strings.save,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: Palette.blueLight),
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
                      fromImportance(importance, strings),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: importance == TodoImportance.important
                            ? Palette.redLight
                            : Palette.labelTertiaryLight,
                      ),
                    ),
                  );
                }).toList(),
                child: Text(
                  fromImportance(_selectedImportance, strings),
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: Palette.labelTertiaryLight),
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
                      _dateTime!.formatDate(),
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Palette.blueLight),
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
              enabled: widget.todoEntity != null,
              minTileHeight: 48,
              minLeadingWidth: 0,
              titleAlignment: ListTileTitleAlignment.center,
              leading: Icon(
                Icons.delete,
                color: widget.todoEntity != null
                    ? Palette.redLight
                    : Palette.labelDisableLight,
              ),
              title: Text(
                strings.delete,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: widget.todoEntity != null
                      ? Palette.redLight
                      : Palette.labelDisableLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
