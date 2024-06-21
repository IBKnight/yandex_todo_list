import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/common/palette.dart';

import 'package:yandex_todo_list/src/features/todos_list/domain/todo_entity.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({super.key, required this.item});

  final TodoEntity item;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.item.id.toString()),
      background: Container(
        color: Palette.greenLight,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.check, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Palette.redLight,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.info),),
        leading: Checkbox(
          value: true,
          onChanged: (value) {},
        ),
        title: Text(
          widget.item.text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        // subtitle:
        //     widget.item.deadline != null ? const Text(Strings.date) : null,
      ),
    );
  }
}
