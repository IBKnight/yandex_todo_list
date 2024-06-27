import 'package:flutter/material.dart';
import '../../../../common/palette.dart';
import '../../../../core/utils/extensions/date_time_extension.dart';
import '../../../../core/utils/extensions/icons_extension.dart';
import '../../../todo_item_edit/presentation/todo_item_edit_screen.dart';

import '../../domain/entities/todo_entity.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({
    super.key,
    required this.item,
    required this.markDone,
    required this.delete,
    required this.checkboxCallback,
  });

  final TodoEntity item;
  final VoidCallback markDone;
  final VoidCallback delete;
  final Function(bool isChecked) checkboxCallback;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool _isChecked = false;

  @override
  void initState() {
    _isChecked = widget.item.done;
    super.initState();
  }

  void _onDismiss(direction) {
    if (direction == DismissDirection.startToEnd) {
      widget.markDone();
    } else if (direction == DismissDirection.endToStart) {
      widget.delete();
    }
  }

  Future<bool> _confirmDissmis(direction) async {
    if (direction == DismissDirection.startToEnd && widget.item.done) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: Key(widget.item.id.toString()),
      onDismissed: _onDismiss,
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
      confirmDismiss: _confirmDissmis,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        trailing: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TodoItemEditScreen(
                  todoEntity: widget.item,
                ),
              ),
            );
          },
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
            return widget.item.importance == TodoImportance.important
                ? Palette.redLight.withOpacity(0.16)
                : Palette.backSecondaryLight;
          }),
          activeColor: Palette.greenLight,
          side: widget.item.importance == TodoImportance.important
              ? theme.checkboxTheme.side?.copyWith(color: Palette.redLight)
              : theme.checkboxTheme.side,
          onChanged: (value) {
            _isChecked = value ?? false;

            widget.checkboxCallback(_isChecked);
          },
        ),
        title: RichText(
          softWrap: false,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: theme.textTheme.bodyLarge?.copyWith(
              decoration:
                  _isChecked ? TextDecoration.lineThrough : TextDecoration.none,
              color: _isChecked
                  ? Palette.labelTertiaryLight
                  : Palette.labelPrimaryLight,
            ),
            children: [
              if (widget.item.importance == TodoImportance.low)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    CustomIcons.arrowDown,
                    size: 16,
                  ),
                ),
              if (widget.item.importance == TodoImportance.important)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    CustomIcons.exclamationPoint,
                    size: 16,
                    color: Palette.redLight,
                  ),
                ),
              TextSpan(
                text: widget.item.text,
              ),
            ],
          ),
        ),
        subtitle: widget.item.deadline != null
            ? Text(
                DateTime.fromMillisecondsSinceEpoch(widget.item.deadline!)
                    .formatDate(),
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: Palette.labelTertiaryLight),
              )
            : null,
      ),
    );
  }
}
