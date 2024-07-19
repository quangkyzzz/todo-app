import 'package:flutter/material.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/presentation/lists/incomplete_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TaskListModel incompleteTask = TaskListModel(
    id: '1',
    listName: 'list1',
    tasks: [
      TaskModel(
        id: '1',
        title: 'task 1',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime.now(),
      ),
      TaskModel(
        id: '2',
        title: 'task 2',
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
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: MyTheme.backgroundGreyColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const TextField(
            style: MyTheme.itemTextStyle,
            decoration: InputDecoration(hintText: 'Enter task name'),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic_outlined),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {},
            child: PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {},
                      child: const Text(
                        'Hide completed item',
                        style: MyTheme.itemTextStyle,
                      ),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8),
        child: IncompleteList(taskList: incompleteTask),
      ),
    );
  }
}
