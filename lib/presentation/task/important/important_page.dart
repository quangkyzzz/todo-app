import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../models/task.dart';
import '../../components/add_floating_button.dart';
import '../../items/task_list_item.dart';
import '../../components/popup_menu.dart';
import '../../../provider/task_list_provider.dart';

class ImportantPage extends StatefulWidget {
  final bool haveCompletedList;

  const ImportantPage({
    super.key,
    this.haveCompletedList = true,
  });

  @override
  State<ImportantPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<ImportantPage> {
  late TaskList defaultTaskList;
  late TaskList importantTaskList;
  bool isExpanded = false;

  @override
  void initState() {
    defaultTaskList = Provider.of<TaskListProvider>(context, listen: false)
        .getTaskList(taskListID: '1');
    importantTaskList = Provider.of<TaskListProvider>(context, listen: true)
        .getTaskList(taskListID: '3');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (importantTaskList.backgroundImage != null)
          (importantTaskList.defaultImage == -1)
              ? Image.file(
                  File(importantTaskList.backgroundImage!),
                  fit: BoxFit.fitHeight,
                )
              : Image.asset(
                  importantTaskList.backgroundImage!,
                  fit: BoxFit.fitHeight,
                )
        else
          const SizedBox(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: importantTaskList.themeColor),
            title: Text(
              'Important',
              style: TextStyle(
                fontSize: 24,
                color: importantTaskList.themeColor,
              ),
            ),
            actions: [
              PopupMenu(
                taskList: importantTaskList,
                toRemove: const [
                  'sort_by',
                  'rename_list',
                  'reorder',
                  'hide_completed_tasks',
                  'duplicate_list',
                  'delete_list',
                  'turn_on_suggestions',
                ],
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Consumer<TaskListProvider>(
              builder: (context, taskListProvider, child) {
                List<Map<Task, TaskList>> importantTasks =
                    taskListProvider.getImportantTask();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: importantTasks.length,
                  itemBuilder: (BuildContext _, int index) {
                    return TaskListItem(
                      mContext: context,
                      task: importantTasks[index].keys.first,
                      taskList: importantTasks[index].values.first,
                      themeColor: importantTaskList.themeColor,
                    );
                  },
                );
              },
            ),
          ),
          floatingActionButton: AddFloatingButton(
            taskList: defaultTaskList,
            isAddToImportant: true,
            themeColor: importantTaskList.themeColor,
          ),
        ),
      ],
    );
  }
}
