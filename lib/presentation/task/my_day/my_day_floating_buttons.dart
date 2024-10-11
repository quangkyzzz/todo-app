import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../models/task.dart';
import '../../../view_models/task_list_view_model.dart';
import '../../items/task_list_item.dart';
import '../../../themes.dart';
import '../../components/add_task_floating_button.dart';

class MyDayFloatingButtons extends StatelessWidget {
  final Color themeColor;
  final TaskList taskList;
  const MyDayFloatingButtons(
      {super.key, required this.taskList, required this.themeColor});

  Future<void> onSuggestionsTap(BuildContext context, Color themeColor) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext _) {
        final taskListViewModel = context.read<TaskListViewModel>();
        List<Task> listRecentTask =
            taskListViewModel.readRecentNotInMyDayTask();
        List<Task> listOlderSuggetTask =
            taskListViewModel.readOlderNotInMyDayTask();
        return DraggableScrollableSheet(
          snap: true,
          minChildSize: 0.1,
          snapSizes: const [0.3, 0.7, 0.8],
          expand: false,
          initialChildSize: 0.3,
          builder: (__, scrollController) {
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
                    StatefulBuilder(builder: (
                      BuildContext ___,
                      setState,
                    ) {
                      return ((listRecentTask.isEmpty) &&
                              (listOlderSuggetTask.isEmpty))
                          ? const Center(
                              child: Text(
                              'There is no suggetion right now!',
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
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: listRecentTask.length,
                                  itemBuilder: (BuildContext ____, int index) {
                                    Task task = listRecentTask[index];
                                    return TaskListItem(
                                      task: task,
                                      themeColor: themeColor,
                                      havePlusIcon: true,
                                      onTapPlus: () {
                                        setState(() {
                                          listRecentTask.remove(task);
                                        });

                                        Task updateTask = task.copyWith(
                                          isOnMyDay: true,
                                        );

                                        context
                                            .read<TaskListViewModel>()
                                            .addMultipleTask(
                                          tasks: [updateTask],
                                        );
                                      },
                                    );
                                  },
                                ),
                                /////////////
                                //Older task
                                (listOlderSuggetTask.isEmpty)
                                    ? const SizedBox()
                                    : const Text(
                                        'Older:',
                                        style: MyTheme.itemTextStyle,
                                      ),
                                const SizedBox(height: 8),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: listOlderSuggetTask.length,
                                  itemBuilder: (BuildContext ____, int index) {
                                    Task task = listOlderSuggetTask[index];
                                    return TaskListItem(
                                      task: task,
                                      themeColor: themeColor,
                                      havePlusIcon: true,
                                      onTapPlus: () {
                                        setState(() {
                                          listOlderSuggetTask.remove(task);
                                        });

                                        Task updateTask = task.copyWith(
                                          isOnMyDay: true,
                                        );

                                        context
                                            .read<TaskListViewModel>()
                                            .addMultipleTask(
                                                tasks: [updateTask]);
                                      },
                                    );
                                  },
                                ),
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
            color: themeColor,
          ),
          child: InkWell(
            splashColor: MyTheme.blackColor,
            customBorder: const CircleBorder(),
            onTap: () async {
              await onSuggestionsTap(context, themeColor);
            },
            child: Ink(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Text(
                'Suggestions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: (themeColor == MyTheme.whiteColor)
                      ? MyTheme.blackColor
                      : MyTheme.whiteColor,
                ),
              ),
            ),
          ),
        ),
        const Spacer(flex: 1),
        AddTaskFloatingButton(
          taskList: taskList,
          isAddToMyDay: true,
          themeColor: themeColor,
        ),
      ],
    );
  }
}
