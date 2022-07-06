import 'package:flutter/material.dart';
import 'package:todo_list/widgets/TaskItem.dart';

class Task {
  Task ({required this.name, required this.checked});
  final String name;
  bool checked;
}

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final List<Task> _taskList = <Task>[];
  final TextEditingController _textFieldController = TextEditingController();
  static const white = Colors.white;
  static var blue = Colors.blue[200];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TODO",
          style: TextStyle(
              fontSize: 25.0,
              color: white,
              fontWeight: FontWeight.w100,
              letterSpacing: 10),
        ),
        backgroundColor: blue,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: blue,
        child: Container(
          decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
            children: _taskList.map((Task task) {
              return TaskItem(
                task: task,
                isChecked: _handleTaskComplete,
              );
            }).toList(),
          ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Future.delayed(
                Duration.zero,
                () => _displayDialog(context),
              ),
          tooltip: 'Add Item',
          backgroundColor: blue,
          child: const IconTheme(
              data: IconThemeData(color: white),
              child:  Icon(Icons.add))),
    );
  }

  Future _displayDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Add a Task',
              style: TextStyle(color: white),
            ),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                  hintText: 'Enter Task Name (e.g. do laundry)'),
            ),
            actions: <Widget>[
              ElevatedButton(
                  child: const Text('ADD', style: TextStyle(color: white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _addTaskItem(_textFieldController.text);
                  },
                  style: ElevatedButton.styleFrom(primary: blue)),
              ElevatedButton(
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(primary: blue))
            ],
          );
        });
  }

  void _addTaskItem(String taskName) {
    setState((){
      _taskList.add(Task(name: taskName, checked: false));
    });
    _textFieldController.clear();
  }

  void _handleTaskComplete (Task task) {
    setState(() {
      task.checked = !task.checked;
    });
  }
}
