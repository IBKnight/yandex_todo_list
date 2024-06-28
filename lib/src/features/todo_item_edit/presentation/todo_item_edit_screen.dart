import 'package:flutter/material.dart';

import 'package:yandex_todo_list/src/common/palette.dart';
import 'package:yandex_todo_list/src/common/strings.dart';
import 'package:yandex_todo_list/src/core/utils/extensions/date_time_extension.dart';
import 'package:yandex_todo_list/src/features/todos_list/domain/todo_entity.dart';

class TodoItemEditScreen extends StatefulWidget {
  const TodoItemEditScreen({super.key, this.todoEntity});

  final TodoEntity? todoEntity;

  @override
  State<TodoItemEditScreen> createState() => _TodoItemEditScreenState();
}

class _TodoItemEditScreenState extends State<TodoItemEditScreen> {
  TodoImportance _selectedImportance = TodoImportance.basic;
  DateTime? _dateTime;
  late bool _hasDeadline;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    if (widget.todoEntity != null) {
      _textEditingController.text = widget.todoEntity!.text;
      _selectedImportance = TodoImportance.values
          .where(
            (importance) => importance == widget.todoEntity!.importance,
          )
          .first;
      _dateTime = widget.todoEntity?.deadline == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              widget.todoEntity?.deadline ??
                  DateTime.now().millisecondsSinceEpoch,
            );
    }

    _hasDeadline = _dateTime != null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              Strings.save,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
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
            Container(
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              constraints: BoxConstraints(
                minHeight: 104,
                minWidth: MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: const Color(0xFF000000).withOpacity(0.06),
                  ),
                  BoxShadow(
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                    color: const Color(0xFF000000).withOpacity(0.12),
                  ),
                ],
                color: Palette.backElevatedLight,
              ),
              child: TextField(
                controller: _textEditingController,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: Strings.whatNeedToDo,
                  contentPadding: EdgeInsetsDirectional.all(16),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 100,
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              minTileHeight: 72,
              contentPadding:
                  const EdgeInsetsDirectional.symmetric(horizontal: 16),
              minLeadingWidth: 0,
              title: Text(
                Strings.priority,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: PopupMenuButton<TodoImportance>(
                initialValue: _selectedImportance,
                onSelected: (TodoImportance item) {
                  setState(() {
                    _selectedImportance = item;
                  });
                },
                itemBuilder: (BuildContext context) => TodoImportance.values
                    .map<PopupMenuEntry<TodoImportance>>(
                        (TodoImportance importance) {
                  return PopupMenuItem<TodoImportance>(
                    value: importance,
                    child: Text(
                      importance.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: importance == TodoImportance.important
                                ? Palette.redLight
                                : Palette.labelTertiaryLight,
                          ),
                    ),
                  );
                }).toList(),
                child: Text(
                  _selectedImportance.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
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
                Strings.doUpTo,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: _dateTime != null
                  ? Text(
                      _dateTime!.formatDate(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Palette.blueLight),
                    )
                  : null,
              trailing: Switch(
                value: _hasDeadline,
                onChanged: (value) {
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
                },
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
                Strings.delete,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
