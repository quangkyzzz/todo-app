import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/presentation/components/add_floating_button.dart';
import 'package:todo_app/presentation/lists/completed_list.dart';
import 'package:todo_app/presentation/lists/incomplete_list.dart';
import 'package:todo_app/presentation/components/popup_menu.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';

//TODO: complete content of important  page
class ImportantPage extends StatefulWidget {
  final bool haveCompletedList;
  final TaskListModel taskList;
  const ImportantPage({
    super.key,
    this.haveCompletedList = false,
    required this.taskList,
  });

  @override
  State<ImportantPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<ImportantPage> {
  bool isExpanded = true;
  late final String id;

  @override
  void initState() {
    id = widget.taskList.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Important',
          style: TextStyle(
            fontSize: 24,
            color: MyTheme.pinkColor,
          ),
        ),
        actions: [
          PopupMenu(
            taskList: widget.taskList,
            toRemove: const [
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
          //TODO: fix this
          builder: (context, taskListProvider, child) {
            TaskListModel taskList = taskListProvider.taskLists.firstWhere(
              (element) => (element.id == widget.taskList.id),
            );

            return Column(children: [
              IncompleteList(taskList: taskList),
              ((widget.haveCompletedList))
                  ? CompletedList(taskList: taskList)
                  : const SizedBox()
            ]);
          },
        ),
      ),
      floatingActionButton: AddFloatingButton(
        taskList: widget.taskList,
      ),
    );
  }
}
