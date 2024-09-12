import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/group_model.dart';
import '../../models/task_list_model.dart';
import '../../view_models/home_page_group_view_model.dart';
import '../../view_models/home_page_task_list_view_model.dart';
import '../components/show_text_edit_dialog.dart';
import '../../themes.dart';
import '../../routes.dart';
import 'home_item.dart';
import '../items/popup_item.dart';

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
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

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
      trailing: HomeGroupTrailing(
        isExpanded: isExpanded,
        context: context,
        groupID: widget.group.id,
        groupName: widget.group.groupName,
      ),
      children: [
        (widget.group.taskLists.isNotEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.group.taskLists.length,
                itemBuilder: (BuildContext context, int index) {
                  TaskListModel item = widget.group.taskLists[index];
                  return Consumer<HomePageTaskListViewModel>(
                    builder: (context, homePageViewModel, child) {
                      int endNumber = 0;
                      for (var element in item.tasks) {
                        if (!element.isCompleted) endNumber++;
                      }
                      return HomeItem(
                        groupID: widget.group.id,
                        taskListID: item.id,
                        icon: Icons.list_outlined,
                        endNumber: endNumber,
                        onTap: () async {
                          await Navigator.of(context).pushNamed(
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
                },
              )
            : const Text(
                'This group is empty',
                style: MyTheme.itemSmallGreyTextStyle,
              ),
      ],
    );
  }
}

class HomeGroupTrailing extends StatelessWidget {
  final BuildContext context;
  final String groupID;
  final String groupName;
  final bool isExpanded;
  const HomeGroupTrailing({
    super.key,
    required this.isExpanded,
    required this.context,
    required this.groupID,
    required this.groupName,
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
                        List<TaskListModel> oldTaskLists = context
                            .read<HomePageGroupViewModel>()
                            .getGroup(groupID)
                            .taskLists;
                        List<TaskListModel>? newTaskLists =
                            await showAddListDialog(
                          context: context,
                          groupID: groupID,
                        );
                        if (!context.mounted) return;
                        if (newTaskLists != null) {
                          List<TaskListModel> addedTaskList = newTaskLists
                              .where(
                                  (element) => !oldTaskLists.contains(element))
                              .toList();
                          List<TaskListModel> removeTaskList = oldTaskLists
                              .where(
                                  (element) => !newTaskLists.contains(element))
                              .toList();

                          context
                              .read<HomePageGroupViewModel>()
                              .addMultipleTaskListToGroup(
                                groupID: groupID,
                                movedTaskLists: addedTaskList,
                              );
                          context
                              .read<HomePageGroupViewModel>()
                              .deleteMultipleTaskListFromGroup(
                                groupID,
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
                          initText: groupName,
                          positiveButton: 'Rename',
                        );
                        if (!context.mounted) return;
                        if (title != null) {
                          context
                              .read<HomePageGroupViewModel>()
                              .renameGroup(groupID, title);
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
                        context
                            .read<HomePageGroupViewModel>()
                            .deleteGroup(groupID);
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

Future<List<TaskListModel>?> showAddListDialog({
  required BuildContext context,
  required String groupID,
}) {
  return showDialog(
    context: context,
    builder: (_) {
      List<TaskListModel> checkedTaskList = [];
      List<TaskListModel> allTaskList = [];
      GroupModel group =
          context.read<HomePageGroupViewModel>().getGroup(groupID);

      checkedTaskList.addAll(group.taskLists);
      allTaskList.addAll(checkedTaskList);

      allTaskList.addAll(
        context
            .watch<HomePageTaskListViewModel>()
            .taskLists
            .where((element) => (int.parse(element.id) > 10)),
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
                  TaskListModel item = allTaskList[index];
                  bool isChecked = checkedTaskList.contains(item);
                  return Row(
                    children: [
                      Text(item.listName),
                      const Spacer(),
                      IconButton(
                          icon: Icon(
                              (isChecked) ? Icons.check : Icons.add_outlined),
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
