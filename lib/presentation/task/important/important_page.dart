import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/components/add_floating_button.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';
import 'package:todo_app/presentation/components/popup_menu.dart';
import 'package:todo_app/provider/task_list_provider.dart';

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
  late TaskListModel defaultTaskList;
  late TaskListModel importantTaskList;
  bool isExpanded = false;

  @override
  void initState() {
    defaultTaskList = Provider.of<TaskListProvider>(context, listen: false)
        .getTaskList(taskListID: '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    importantTaskList = Provider.of<TaskListProvider>(context, listen: true)
        .getTaskList(taskListID: '3');
    return Stack(
      fit: StackFit.expand,
      children: [
        (importantTaskList.backgroundImage != null)
            ? Image.file(
                importantTaskList.backgroundImage!,
                fit: BoxFit.fitHeight,
              )
            : const SizedBox(),
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
                List<Map<TaskModel, TaskListModel>> importantTasks =
                    taskListProvider.getImportantTask();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: importantTasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskListItem(
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
