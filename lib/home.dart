import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // save data
  final List<String> todoList = <String>[];
  // text field
  final TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do List'),
      ),
      body: ListView(
        children: [
          for (var todo in todoList)
            // !!!!!!
            // could improve "ListTile" to look better or have functionality
            ListTile(
              title: Text(todo),
            ),
        ],
      ),
      // add items to the to-do list
      floatingActionButton: FloatingActionButton(
          onPressed: () => Future.delayed(
                Duration.zero,
                () => displayDialog(context),
              ),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }

  Future displayDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a Task'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                  hintText: 'Enter Task Name (e.g. do laundry)'),
            ),
            actions: <Widget>[
              // add button
              ElevatedButton(
                child: const Text('ADD'),
                onPressed: () {
                  setState(() {
                    todoList.add(_textFieldController.text);
                    _textFieldController.clear();
                    Navigator.of(context).pop();
                  });
                },
              ),
              // Cancel button
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
