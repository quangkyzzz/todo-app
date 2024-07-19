import 'package:flutter/material.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';

class ReorderPage extends StatefulWidget {
  const ReorderPage({super.key});

  @override
  State<ReorderPage> createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
  TaskListModel incompleteTask = TaskListModel(
    id: '666',
    listName: 'order',
    tasks: [
      TaskModel(
        id: '6',
        title: 'task 1',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime.now(),
      ),
      TaskModel(
        id: '7',
        title: 'task 2',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime.now(),
      ),
      TaskModel(
        id: '8',
        title: 'task 3',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime.now(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reorder tasks',
          style: MyTheme.titleTextStyle,
        ),
      ),
      body: ReorderableListView(
          header: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Tap and hold to reorder task',
              style: MyTheme.itemTextStyle,
            ),
          ),
          children: incompleteTask.tasks.map((item) {
            return TaskListItem(
              key: Key(item.id),
              task: item,
              taskList: incompleteTask,
            );
          }).toList(),
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = incompleteTask.tasks.removeAt(oldIndex);
              incompleteTask.tasks.insert(newIndex, item);
            });
          }),
    );
  }
}
