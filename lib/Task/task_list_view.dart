import 'package:flutter/material.dart';
import 'package:todo_app/Task/components/incomplete_list.dart';
import 'package:todo_app/Task/components/task_list_popup_menu.dart';
import 'package:todo_app/constant/app_configs.dart';

class TaskListView extends StatefulWidget {
  final bool haveCompletedList;
  const TaskListView({super.key, this.haveCompletedList = true});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
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
    bool isExpanded = true;
    return Scaffold(
      appBar: AppBar(
        title: (widget.haveCompletedList)
            ? const Text(
                'Tasks',
                style: TextStyle(
                  fontSize: 40,
                  color: AppConfigs.blueColor,
                ),
              )
            : const Text(
                'Important',
                style: TextStyle(
                  fontSize: 40,
                  color: AppConfigs.pinkColor,
                ),
              ),
        actions: const [TaskListPopupMenu()],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          IncompleteList(taskList: incompleteTask),
          (widget.haveCompletedList)
              ? ExpansionTile(
                  initiallyExpanded: true,
                  title: const Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppConfigs.blueColor,
                    ),
                  ),
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      isExpanded = expanded;
                    });
                  },
                  trailing: Icon(isExpanded
                      ? Icons.expand_more
                      : Icons.keyboard_arrow_left),
                  children: [
                    IncompleteList(
                      taskList: incompleteTask,
                    ),
                  ],
                )
              : const SizedBox()
        ]),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppConfigs.blueColor,
        ),
        child: InkWell(
          splashColor: AppConfigs.blackColor,
          customBorder: const CircleBorder(),
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  color: AppConfigs.backgroundGreyColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        shape: const CircleBorder(),
                        value: false,
                        onChanged: (bool? value) {},
                      ),
                      const Expanded(
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Add a task',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.arrow_upward_outlined),
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: Ink(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            height: 70,
            width: 70,
            child: const Icon(
              Icons.add,
              size: 40,
              color: AppConfigs.blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
