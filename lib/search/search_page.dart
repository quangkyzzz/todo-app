import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/reuse_part/incomplete_list_component.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> incompleteTask = [
    {
      'taskID': '1',
      'title': 'task 1',
      'isCompleted': false,
      'note': 'xdd',
      'filePath': 'xdd',
      'dueDate': DateTime(2021, 1, 22),
      'notiTime': DateTime(2024, 3, 15, 12, 12),
    },
    {
      'taskID': '2',
      'title': 'task 2',
      'isCompleted': false,
      'dueDate': DateTime.now(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: MyTheme.backgroundGreyColor,
            borderRadius: BorderRadius.circular(10),
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
          const SizedBox(width: 10),
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
        padding: const EdgeInsets.only(top: 10),
        child: IncompleteListComponent(taskList: incompleteTask),
      ),
    );
  }
}
