import 'package:flutter/material.dart';
import 'package:todo_app/models/group_model.dart';
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
  List<Map<String, dynamic>> listPopupMenuItem = [
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
      'onTap': () {},
    },
    {
      'value': 'ungroup',
      'text': 'Ungroup list',
      'icon': Icons.clear_all_outlined,
      'onTap': () {},
    },
  ];
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
                        onTap: item['onTap'],
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
      children: widget.group.listTaskList!.map((item) {
        return HomeItem(
          text: item.listName,
          icon: Icons.list_outlined,
          iconColor: MyTheme.blueColor,
          endNumber: 1,
          onTap: () {
            Navigator.of(context).pushNamed(taskListRoute);
          },
        );
      }).toList(),
    );
  }
}
