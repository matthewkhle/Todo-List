import 'package:flutter/material.dart';
import 'package:todo_list/home.dart';

class TaskItem extends StatelessWidget {
  TaskItem({required this.task, required this.isChecked})
      : super(key: ObjectKey(task));

  final Task task;
  final isChecked;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;
    return const TextStyle(
      color: Colors.grey,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        isChecked(task);
      },
      leading: Icon(Icons.circle_rounded, color: Colors.blue[200]),
      title: Text(task.name, style: _getTextStyle(task.checked)),
    );
  }
}
