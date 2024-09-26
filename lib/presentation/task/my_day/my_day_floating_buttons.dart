import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task_list.dart';
import '../../../models/task.dart';
import '../../../provider/settings_provider.dart';
import '../../../view_models/task_list_view_model.dart';
import '../../items/task_list_item.dart';
import '../../../themes.dart';
import '../../components/add_floating_button.dart';

class MyDayFloatingButtons extends StatefulWidget {
  final Color themeColor;
  final TaskList taskList;
  const MyDayFloatingButtons(
      {super.key, required this.taskList, required this.themeColor});

  @override
  State<MyDayFloatingButtons> createState() => _MyDayFloatingButtonsState();
}

class _MyDayFloatingButtonsState extends State<MyDayFloatingButtons> {
  late TaskList taskList;

  @override
  void initState() {
    taskList = widget.taskList;
    super.initState();
  }

  Future<void> onSuggestionsTap(BuildContext context, Color themeColor) async {
    final taskListViewModel =
        Provider.of<TaskListViewModel>(context, listen: false);
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext _) {
        return DraggableScrollableSheet(
          snap: true,
          minChildSize: 0.2,
          snapSizes: const [0.3, 0.7, 0.8],
          expand: false,
          initialChildSize: 0.3,
          builder: (__, scrollController) {
            return ListenableProvider.value(
              value: taskListViewModel,
              child: SingleChildScrollView(
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
                      Builder(builder: (BuildContext ___) {
                        List<Task> listRecentTask =
                            taskListViewModel.readRecentNotInMyDayTask();
                        List<Task> listOlderSuggetTask =
                            taskListViewModel.readOlderNotInMyDayTask();
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
                                    itemBuilder:
                                        (BuildContext ____, int index) {
                                      Task task = listRecentTask[index];

                                      return TaskListItem(
                                        mContext: context,
                                        task: task,
                                        themeColor: themeColor,
                                        havePlusIcon: true,
                                        onTapPlus: () {
                                          //FIXME: must fix add tosk to My Day
                                          setState(() {
                                            listRecentTask.remove(task);
                                          });
                                          context
                                              .read<TaskListViewModel>()
                                              .updateTaskListWith(
                                                settings: context
                                                    .read<SettingsProvider>()
                                                    .settings,
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
                                    itemBuilder:
                                        (BuildContext ____, int index) {
                                      Task task = listOlderSuggetTask[index];
                                      return TaskListItem(
                                        mContext: context,
                                        task: task,
                                        themeColor: themeColor,
                                        havePlusIcon: true,
                                        onTapPlus: () {
                                          setState(() {
                                            listOlderSuggetTask.remove(task);
                                          });
                                          //FIXME: must fix add tosk to My Day
                                          context
                                              .read<TaskListViewModel>()
                                              .updateTaskListWith(
                                                settings: context
                                                    .read<SettingsProvider>()
                                                    .settings,
                                              );
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
            onTap: () async {
              await onSuggestionsTap(context, widget.themeColor);
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
