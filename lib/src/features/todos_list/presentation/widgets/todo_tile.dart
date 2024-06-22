import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/common/palette.dart';
import 'package:yandex_todo_list/src/core/utils/extensions/date_time_extension.dart';

import 'package:yandex_todo_list/src/features/todos_list/domain/todo_entity.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({super.key, required this.item});

  final TodoEntity item;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  late bool _isChecked;

  @override
  void initState() {
    _isChecked = widget.item.done;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.item.id.toString()),
      onDismissed: (direction) {
      },
      background: Container(
        color: Palette.greenLight,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsetsDirectional.only(start: 20),
        child: const Icon(Icons.check, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Palette.redLight,
        alignment: Alignment.centerRight,
        padding: const EdgeInsetsDirectional.only(end: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.info_outline),
        ),
        leading: Checkbox(
          value: _isChecked,
          /// Выбор цвета в зависимости от стейта чекбокса
          fillColor:
              WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return Palette.greenLight;
            }
            return widget.item.importance == 'important'
                ? Palette.redLight.withOpacity(0.16)
                : Palette.backSecondaryLight;
          }),
          activeColor: Palette.greenLight,
          side: widget.item.importance == 'important'
              ? Theme.of(context)
                  .checkboxTheme
                  .side
                  ?.copyWith(color: Palette.redLight)
              : Theme.of(context).checkboxTheme.side,
          onChanged: (value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
        ),
        title: Text(
          widget.item.text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: widget.item.deadline != null
            ? Text(
                DateTime.now()
                    .add((Duration(seconds: widget.item.deadline!)))
                    .formatDate(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Palette.labelTertiaryLight),
              )
            : null,
      ),
    );
  }
}
