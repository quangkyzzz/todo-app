import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/group_model.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/presentation/components/show_text_edit_dialog.dart';
import 'package:todo_app/provider/group_provider.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/presentation/home/home_item.dart';
import 'package:todo_app/presentation/items/popup_item.dart';

class HomeGroup extends StatefulWidget {
  final GroupModel group;
  const HomeGroup({
    super.key,
    required this.group,
  });

  @override
  State<HomeGroup> createState() => _HomeGroupState();
}

class _HomeGroupState extends State<HomeGroup> {
  late GroupProvider groupProvider;
  late TaskListProvider taskListProvider;
  late List<Map<String, dynamic>> listPopupMenuItem = [
    {
      'value': 'add_or_remove_lists',
      'text': 'Add/remove lists',
      'icon': Icons.list_outlined,
      'onTap': onTapAddRemoveList,
    },
    {
      'value': 'rename',
      'text': 'Rename group',
      'icon': Icons.edit_note_outlined,
      'onTap': onTapRenameGroup,
    },
    {
      'value': 'ungroup',
      'text': 'Ungroup list',
      'icon': Icons.clear_all_outlined,
      'onTap': onTapUngroupList,
    },
  ];

  @override
  void initState() {
    groupProvider = Provider.of<GroupProvider>(context, listen: false);
    taskListProvider = Provider.of<TaskListProvider>(context, listen: false);
    super.initState();
  }

  void onTapAddRemoveList(BuildContext context, String groupID) async {
    List<TaskListModel> oldTaskLists =
        groupProvider.getGroup(groupID).taskLists;
    List<TaskListModel>? newTaskLists = await showAddListDialog(
      context: context,
      groupID: groupID,
    );
    if (!mounted) return;
    if (newTaskLists != null) {
      List<TaskListModel> addedTaskList = newTaskLists
          .where((element) => !oldTaskLists.contains(element))
          .toList();

      List<TaskListModel> removeTaskList = oldTaskLists
          .where((element) => !newTaskLists.contains(element))
          .toList();

      Provider.of<GroupProvider>(context, listen: false).addTaskList(
        groupID,
        addedTaskList,
      );

      Provider.of<GroupProvider>(context, listen: false).deleteMultipleTaskList(
        groupID,
        removeTaskList,
      );
    }
  }

  void onTapRenameGroup(BuildContext context, String groupID) async {
    String? title = await showTextEditDialog(
      context: context,
      title: 'Rename group ',
      hintText: '',
      initText: widget.group.groupName,
      positiveButton: 'Rename',
    );
    if (!mounted) return;
    if (title != null) {
      groupProvider.renameGroup(groupID, title);
    }
  }

  void onTapUngroupList(BuildContext context, String groupID) {
    groupProvider.deleteGroup(groupID);
  }

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.group.groupName,
        style: MyTheme.itemTextStyle,
      ),
      tilePadding: const EdgeInsets.only(left: 8),
      childrenPadding: const EdgeInsets.only(left: 18),
      onExpansionChanged: (bool expanded) {
        setState(() {
          isExpanded = expanded;
        });
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          (isExpanded)
              ? PopupMenuButton(
                  offset: const Offset(0, 40),
                  itemBuilder: (context) {
                    return listPopupMenuItem.map((item) {
                      return PopupMenuItem(
                        onTap: () {
                          item['onTap'](context, widget.group.id);
                        },
                        value: item['value'],
                        child: PopupItem(
                          text: item['text'],
                          icon: item['icon'],
                        ),
                      );
                    }).toList();
                  },
                )
              : const SizedBox(),
          Icon(isExpanded ? Icons.expand_more : Icons.keyboard_arrow_left),
        ],
      ),
      children: (widget.group.taskLists.isNotEmpty)
          ? widget.group.taskLists.map((item) {
              return Consumer<TaskListProvider>(
                builder: (context, taskListProvider, child) {
                  int endNumber = 0;

                  TaskListModel taskList =
                      taskListProvider.getTaskList(taskListID: item.id);
                  for (var element in taskList.tasks) {
                    if (!element.isCompleted) endNumber++;
                  }
                  return HomeItem(
                    text: item.listName,
                    icon: Icons.list_outlined,
                    iconColor: MyTheme.blueColor,
                    endNumber: endNumber,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        taskListRoute,
                        arguments: {
                          'haveCompletedList': true,
                          'taskList': item,
                        },
                      );
                    },
                  );
                },
              );
            }).toList()
          : [
              const Text(
                'This group is empty',
                style: MyTheme.itemSmallGreyTextStyle,
              )
            ],
    );
  }
}

Future<List<TaskListModel>?> showAddListDialog({
  required BuildContext context,
  required String groupID,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      List<TaskListModel> checkedTaskList = [];
      List<TaskListModel> allTaskList = [];

      return AlertDialog(
        scrollable: true,
        title: const Text(
          'Select lists to add or remove',
          style: MyTheme.itemTextStyle,
        ),
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 235,
          width: 300,
          child: SingleChildScrollView(
            child: Consumer2<GroupProvider, TaskListProvider>(
              builder: (
                context,
                groupProvider,
                taskListProvider,
                child,
              ) {
                GroupModel group = groupProvider.getGroup(groupID);

                checkedTaskList.addAll(group.taskLists);
                allTaskList.addAll(checkedTaskList);

                allTaskList.addAll(
                  taskListProvider.taskLists.where((element) =>
                      ((element.groupID == null) &&
                          (int.parse(element.id) > 10))),
                );
                return StatefulBuilder(builder: (context, setState) {
                  return Column(
                    children: allTaskList.map((item) {
                      bool isChecked = checkedTaskList.contains(item);
                      return Row(
                        children: [
                          Text(item.listName),
                          const Spacer(),
                          IconButton(
                              icon: Icon((isChecked)
                                  ? Icons.check
                                  : Icons.add_outlined),
                              onPressed: () {
                                setState(() {
                                  if (checkedTaskList.contains(item)) {
                                    checkedTaskList.remove(item);
                                    isChecked = !isChecked;
                                  } else {
                                    checkedTaskList.add(item);
                                    isChecked = !isChecked;
                                  }
                                });
                              })
                        ],
                      );
                    }).toList(),
                  );
                });
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () {
              Navigator.pop(context, checkedTaskList);
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
