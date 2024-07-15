import 'package:flutter/material.dart';
import 'package:todo_app/models/step_model.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/components/add_floating_button.dart';
import 'package:todo_app/presentation/lists/incomplete_list.dart';
import 'package:todo_app/presentation/components/popup_menu.dart';
import 'package:todo_app/themes.dart';

class TaskListPage extends StatefulWidget {
  final bool haveCompletedList;
  const TaskListPage({super.key, this.haveCompletedList = true});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  bool isExpanded = true;
  TaskListModel incompleteTask = TaskListModel(
    id: '1',
    listName: 'list1',
    taskList: [
      TaskModel(
        id: '1',
        title: 'task 1',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime(2024, 6, 9),
        stepList: const [
          StepModel(
            id: '1',
            stepName: 'step 1',
            isCompleted: false,
          ),
          StepModel(
            id: '2',
            stepName: 'step 2',
            isCompleted: true,
          ),
        ],
      ),
      TaskModel(
        id: '2',
        title: 'few day',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime(2024, 6, 2),
        dueDate: DateTime(2024, 6, 2),
        repeatFrequency: 'gg',
      ),
      TaskModel(
        id: '2',
        title: 'few hour',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime(2024, 7, 2, 7),
      ),
      TaskModel(
        id: '2',
        title: 'recent',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime(2024, 7, 2, 9, 38),
      ),
      TaskModel(
        id: '2',
        title: 'few minute',
        isCompleted: false,
        isImportant: false,
        createDate: DateTime(2024, 7, 2, 9, 30),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.haveCompletedList)
            ? const Text(
                'Tasks',
                style: TextStyle(
                  fontSize: 24,
                  color: MyTheme.blueColor,
                ),
              )
            : const Text(
                'Important',
                style: TextStyle(
                  fontSize: 24,
                  color: MyTheme.pinkColor,
                ),
              ),
        actions: const [
          PopupMenu(
            toRemove: ['hide_completed_tasks'],
          )
        ],
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
                      fontSize: 18,
                      color: MyTheme.blueColor,
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
      floatingActionButton: const AddFloatingButton(),
    );
  }
}
