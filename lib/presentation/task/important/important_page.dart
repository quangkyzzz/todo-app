import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../view_models/task_list_view_model.dart';
import '../../components/add_floating_button.dart';
import '../../items/task_list_item.dart';
import '../../components/task_list_popup_menu.dart';

class ImportantPage extends StatefulWidget {
  const ImportantPage({
    super.key,
  });

  @override
  State<ImportantPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<ImportantPage> {
  late TaskList importantTaskList;

  @override
  void initState() {
    context.read<TaskListViewModel>().getImportantTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    importantTaskList = context.watch<TaskListViewModel>().currentTaskList;
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
            actions: const [
              TaskListPopupMenu(
                toRemove: [
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
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: importantTaskList.tasks.length,
              itemBuilder: (BuildContext _, int index) {
                return TaskListItem(
                  mContext: context,
                  task: importantTaskList.tasks[index],
                  themeColor: importantTaskList.themeColor,
                );
              },
            ),
          ),
          floatingActionButton: AddFloatingButton(
            taskList: importantTaskList,
            isAddToImportant: true,
            themeColor: importantTaskList.themeColor,
          ),
        ),
      ],
    );
  }
}
