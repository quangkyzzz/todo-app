import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/group_model.dart';
import 'package:todo_app/presentation/components/show_text_edit_dialog.dart';
import 'package:todo_app/provider/group_provider.dart';
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
  late List<Map<String, dynamic>> listPopupMenuItem = [
    {
      'value': 'add_or_remove_lists',
      'text': 'Add/remove lists',
      'icon': Icons.list_outlined,
      'onTap': () {},
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
  void onTapRenameGroup(BuildContext context, String id) async {
    String? title = await showTextEditDialog(
      context: context,
      title: 'Rename group ',
      hintText: '',
      initText: widget.group.groupName,
      positiveButton: 'Rename',
    );
    if (!mounted) return;
    if (title != null) {
      Provider.of<GroupProvider>(context, listen: false).renameGroup(id, title);
    }
  }

  void onTapUngroupList(BuildContext context, String id) {
    Provider.of<GroupProvider>(context, listen: false).deleteGroup(id);
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
              return HomeItem(
                text: item.listName,
                icon: Icons.list_outlined,
                iconColor: MyTheme.blueColor,
                endNumber: 1,
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
            }).toList()
          : [
              const Text(
                'This group is empty',
                style: MyTheme.itemSmallTextStyle,
              )
            ],
    );
  }
}
