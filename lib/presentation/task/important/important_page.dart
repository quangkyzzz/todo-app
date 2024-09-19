import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../models/task.dart';
import '../../../view_models/group_view_model.dart';
import '../../../view_models/task_list_view_model.dart';
import '../../../view_models/task_map_view_model.dart';
import '../../components/add_floating_button.dart';
import '../../items/task_list_item.dart';
import '../../components/popup_menu.dart';

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
  late TaskList newTaskDestinationTaskList;
  late TaskList importantTaskList;
  bool isExpanded = false;

  @override
  void didChangeDependencies() {
    newTaskDestinationTaskList =
        context.read<GroupViewModel>().readGroupByID('1').taskLists[0];
    importantTaskList = context.watch<TaskListViewModel>().currentTaskList;
    super.didChangeDependencies();
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
            child: Consumer<TaskMapViewModel>(
              builder: (_, taskMapViewModel, child) {
                List<Map<Task, TaskList>> importantTasks =
                    taskMapViewModel.readImportantTask();
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
                      onTapCheck: (bool? value) {
                        context.read<TaskMapViewModel>().updateTaskWith(
                            taskID: importantTasks[index].keys.first.id,
                            isCompleted: value);
                      },
                      onTapStar: () {
                        context.read<TaskMapViewModel>().updateTaskWith(
                              taskID: importantTasks[index].keys.first.id,
                              isImportant:
                                  !importantTasks[index].keys.first.isImportant,
                            );
                      },
                    );
                  },
                );
              },
            ),
          ),
          floatingActionButton: AddFloatingButton(
            taskList: newTaskDestinationTaskList,
            isAddToImportant: true,
            themeColor: importantTaskList.themeColor,
          ),
        ),
      ],
    );
  }
}
