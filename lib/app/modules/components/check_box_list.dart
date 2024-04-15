import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_todo/app/modules/components/constants.dart';
import 'package:flutter_todo/app/todo_model.dart';

list(Todo todo, index, length, controller) {
  bool checked = todo.status;
  String title = todo.title.toString();
  String subtitle = todo.dueDate.toString();
  IconData icon;

  if (todo.category == CAT_DATE) {
    icon = Icons.calendar_today;
  } else if (todo.category == CAT_CHAMP) {
    icon = Icons.leaderboard;
  } else {
    icon = Icons.note;
  }

  return Dismissible(
    key: Key(todo.id.toString()),
    direction: DismissDirection.startToEnd,
    background: Container(
      decoration:
          BoxDecoration(color: Colors.red, borderRadius: border(index, length)),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: const Icon(Icons.delete, color: Colors.white),
    ),
    onDismissed: (direction) {
      controller.deleteData(todo);
    },
    child: Material(
      type: MaterialType.transparency,
      child: CheckboxListTile(
        contentPadding: const EdgeInsets.all(16),
        value: checked,
        shape: RoundedRectangleBorder(borderRadius: border(index, length)),
        onChanged: (value) {
          // update todo
          controller.updateData(todo, value ?? false);
        },
        title: Text(
          title,
          style: TextStyle(
              decoration:
                  checked ? TextDecoration.lineThrough : TextDecoration.none),
        ),
        tileColor: Colors.white,
        subtitle: Text(
          DateFormat(DateFormat.HOUR_MINUTE).format(DateTime.parse(subtitle)),
          style: TextStyle(
              decoration:
                  checked ? TextDecoration.lineThrough : TextDecoration.none),
        ),
        secondary: CircleAvatar(
          backgroundColor: todo.category == CAT_NOTES
              ? const Color(COL_NOTES)
              : todo.category == CAT_CHAMP
                  ? const Color(COL_CHAMP)
                  : const Color(COL_DATE),
          child: Icon(icon),
        ),
      ),
    ),
  );
}

border(index, length) {
  if (index == 0 && length == 1) {
    return const BorderRadius.all(Radius.circular(20));
  } else if (index == 0) {
    return const BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(10));
  } else if (index == length - 1) {
    return const BorderRadius.only(
        bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10));
  } else {
    return BorderRadius.circular(0);
  }
}
