import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';
import 'package:todo_app/Task/components/completed_list.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<Map<String, dynamic>> incompleteTask = [
    {
      'taskID': '1',
      'title': 'task 1',
      'isCompleted': false,
      'note': 'xdd',
      'filePath': 'xdd'
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
            color: AppConfigs.backgroundGreyColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const TextField(
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(hintText: 'Enter task name'),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: const Icon(Icons.mic_outlined),
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
                        style: TextStyle(fontSize: 20),
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
        child: CompletedList(taskList: incompleteTask),
      ),
    );
  }
}
