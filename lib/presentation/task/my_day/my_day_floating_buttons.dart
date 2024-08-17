import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/presentation/components/add_floating_button.dart';

class MyDayFloatingButtons extends StatefulWidget {
  final Color themeColor;
  final TaskListModel taskList;
  const MyDayFloatingButtons(
      {super.key, required this.taskList, required this.themeColor});

  @override
  State<MyDayFloatingButtons> createState() => _MyDayFloatingButtonsState();
}

class _MyDayFloatingButtonsState extends State<MyDayFloatingButtons> {
  late TaskListModel taskList;

  @override
  void initState() {
    taskList = widget.taskList;
    super.initState();
  }

  void onSuggestionsTap(BuildContext context, Color themeColor) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          snap: true,
          minChildSize: 0.2,
          snapSizes: const [0.3, 0.7, 0.8],
          expand: false,
          initialChildSize: 0.3,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(
                        Icons.horizontal_rule_rounded,
                        size: 48,
                      ),
                    ),
                    Consumer<TaskListProvider>(builder:
                        (BuildContext context, taskListProvider, child) {
                      ListTaskMap listRecentTask =
                          taskListProvider.getRecentNotInMyDayTask();
                      ListTaskMap listOlderSuggetTask =
                          taskListProvider.getOlderNotInMyDayTask();
                      return ((listRecentTask.isEmpty) &&
                              (listOlderSuggetTask.isEmpty))
                          ? const Center(
                              child: Text(
                              'There is no suggetion right now !',
                              style: MyTheme.itemTextStyle,
                            ))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //////////////
                                //Recent task
                                (listRecentTask.isEmpty)
                                    ? const SizedBox()
                                    : const Text(
                                        'Recenly added:',
                                        style: MyTheme.itemTextStyle,
                                      ),
                                const SizedBox(height: 8),
                                ...listRecentTask.map((pair) {
                                  TaskModel task = pair.keys.first;
                                  TaskListModel taskList = pair.values.first;
                                  return TaskListItem(
                                    task: task,
                                    taskList: taskList,
                                    themeColor: themeColor,
                                    havePlusIcon: true,
                                    onTapPlus: () {
                                      taskListProvider.updateTaskWith(
                                        taskListID: taskList.id,
                                        taskID: task.id,
                                        isOnMyDay: true,
                                      );
                                    },
                                  );
                                }),
                                ////////////
                                //Older task
                                (listOlderSuggetTask.isEmpty)
                                    ? const SizedBox()
                                    : const Text(
                                        'Older:',
                                        style: MyTheme.itemTextStyle,
                                      ),
                                const SizedBox(height: 8),
                                ...listOlderSuggetTask.map((pair) {
                                  TaskModel task = pair.keys.first;
                                  TaskListModel taskList = pair.values.first;
                                  return TaskListItem(
                                    task: task,
                                    taskList: taskList,
                                    themeColor: themeColor,
                                    havePlusIcon: true,
                                    onTapPlus: () {
                                      taskListProvider.updateTaskWith(
                                        taskListID: taskList.id,
                                        taskID: task.id,
                                        isOnMyDay: true,
                                      );
                                    },
                                  );
                                }),
                              ],
                            );
                    }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(18),
            color: widget.themeColor,
          ),
          child: InkWell(
            splashColor: MyTheme.blackColor,
            customBorder: const CircleBorder(),
            onTap: () {
              onSuggestionsTap(context, widget.themeColor);
            },
            child: Ink(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Text(
                'Suggestions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: (widget.themeColor == MyTheme.whiteColor)
                      ? MyTheme.blackColor
                      : MyTheme.whiteColor,
                ),
              ),
            ),
          ),
        ),
        const Spacer(flex: 1),
        AddFloatingButton(
          taskList: taskList,
          isAddToMyDay: true,
          themeColor: widget.themeColor,
        ),
      ],
    );
  }
}
