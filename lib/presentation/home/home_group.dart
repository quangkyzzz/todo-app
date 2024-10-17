import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/group.dart';
import 'package:todo_app/models/task_list.dart';
import 'package:todo_app/view_models/group_view_model.dart';
import 'package:todo_app/presentation/components/show_text_edit_dialog.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/presentation/home/home_item.dart';
import 'package:todo_app/presentation/items/popup_item.dart';

class HomeGroup extends StatefulWidget {
  final Group group;
  const HomeGroup({
    super.key,
    required this.group,
  });

  @override
  State<HomeGroup> createState() => _HomeGroupState();
}

class _HomeGroupState extends State<HomeGroup> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
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
        trailing: HomeGroupTrailing(
          isExpanded: isExpanded,
          context: context,
          group: widget.group,
        ),
        children: [
          (widget.group.taskLists.isNotEmpty)
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.group.taskLists.length,
                  itemBuilder: (BuildContext context, int index) {
                    TaskList item = widget.group.taskLists[index];
                    int endNumber = 0;
                    for (var element in item.tasks) {
                      if (!element.isCompleted) endNumber++;
                    }
                    return HomeItem(
                      group: widget.group,
                      taskList: item,
                      icon: Icons.list_outlined,
                      endNumber: endNumber,
                      onTap: () async {
                        await Navigator.of(context).pushNamed(
                          taskListRoute,
                          arguments: item,
                        );
                      },
                    );
                  },
                )
              : const Padding(
                  padding: EdgeInsets.only(top: 6, bottom: 24),
                  child: Text(
                    'This group is empty',
                    style: MyTheme.itemSmallGreyTextStyle,
                  ),
                ),
        ],
      ),
    );
  }
}

class HomeGroupTrailing extends StatelessWidget {
  final BuildContext context;
  final Group group;
  final bool isExpanded;
  const HomeGroupTrailing({
    super.key,
    required this.isExpanded,
    required this.context,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        (isExpanded)
            ? PopupMenuButton(
                offset: const Offset(0, 40),
                itemBuilder: (_) {
                  return [
                    PopupMenuItem(
                      onTap: () async {
                        List<TaskList> oldTaskLists = group.taskLists;
                        List<TaskList>? newTaskLists = await showAddListDialog(
                          context: context,
                          group: group,
                        );
                        if (!context.mounted) return;
                        if (newTaskLists != null) {
                          List<TaskList> addedTaskList = newTaskLists
                              .where(
                                  (element) => !oldTaskLists.contains(element))
                              .toList();
                          context
                              .read<GroupViewModel>()
                              .addMultipleTaskListToGroup(
                                group: group,
                                movedTaskLists: addedTaskList,
                              );

                          List<TaskList> removeTaskList = oldTaskLists
                              .where(
                                  (element) => !newTaskLists.contains(element))
                              .toList();
                          context
                              .read<GroupViewModel>()
                              .deleteMultipleTaskListFromGroup(
                                group,
                                removeTaskList,
                              );
                        }
                      },
                      value: 'add_or_remove_lists',
                      child: const CustomPopupItem(
                        text: 'Add/remove lists',
                        icon: Icons.list_outlined,
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () async {
                        String? title = await showTextEditDialog(
                          context: context,
                          title: 'Rename group ',
                          hintText: '',
                          initText: group.groupName,
                          positiveButton: 'Rename',
                        );
                        if (!context.mounted) return;
                        if (title != null) {
                          context
                              .read<GroupViewModel>()
                              .renameGroup(group, title);
                        }
                      },
                      value: 'rename',
                      child: const CustomPopupItem(
                        text: 'Rename group',
                        icon: Icons.edit_note_outlined,
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        context.read<GroupViewModel>().deleteGroup(group);
                      },
                      value: 'ungroup',
                      child: const CustomPopupItem(
                        text: 'Ungroup list',
                        icon: Icons.clear_all_outlined,
                      ),
                    ),
                  ];
                },
              )
            : const SizedBox(),
        Icon(isExpanded ? Icons.expand_more : Icons.keyboard_arrow_left),
      ],
    );
  }
}

Future<List<TaskList>?> showAddListDialog({
  required BuildContext context,
  required Group group,
}) {
  return showDialog(
    context: context,
    builder: (_) {
      List<TaskList> checkedTaskList = [];
      List<TaskList> allTaskList = [];

      checkedTaskList.addAll(group.taskLists);
      allTaskList.addAll(checkedTaskList);

      allTaskList.addAll(
        context.read<GroupViewModel>().readGroupByID('1').taskLists,
      );
      allTaskList.removeWhere(
        (element) => (int.parse(element.id) < int.parse('10')),
      );
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
            child: StatefulBuilder(builder: (_, setState) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: allTaskList.length,
                itemBuilder: (BuildContext context, int index) {
                  TaskList item = allTaskList[index];
                  bool isChecked = checkedTaskList.contains(item);
                  return Row(
                    children: [
                      Text(item.title),
                      const Spacer(),
                      IconButton(
                          icon: Icon(
                            (isChecked) ? Icons.check : Icons.add_outlined,
                          ),
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
                },
              );
            }),
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
