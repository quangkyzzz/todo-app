import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/components/popup_menu_component.dart';
import 'package:todo_app/presentation/home/home_item.dart';

class HomeGroup extends StatefulWidget {
  const HomeGroup({super.key});

  @override
  State<HomeGroup> createState() => _HomeGroupState();
}

class _HomeGroupState extends State<HomeGroup> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        'Group 1',
        style: MyTheme.itemTextStyle,
      ),
      tilePadding: const EdgeInsets.only(left: 7),
      childrenPadding: const EdgeInsets.only(left: 20),
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
                    return [
                      PopupMenuItem(
                        value: 'add_or_remove_lists',
                        child: PopupItem(
                          text: 'Add/Remove lists',
                          icon: Icons.list_outlined,
                          onTap: () {},
                        ),
                      ),
                      PopupMenuItem(
                        value: 'rename',
                        child: PopupItem(
                          text: 'Rename group',
                          icon: Icons.edit_note_outlined,
                          onTap: () {},
                        ),
                      ),
                      PopupMenuItem(
                        value: 'ungroup',
                        child: PopupItem(
                          text: 'Ungroup lists',
                          icon: Icons.clear_all_outlined,
                          onTap: () {},
                        ),
                      ),
                    ];
                  },
                )
              : const SizedBox(),
          Icon(isExpanded ? Icons.expand_more : Icons.keyboard_arrow_left),
        ],
      ),
      children: [
        HomeItem(
          onTap: () {
            Navigator.of(context).pushNamed(taskListRoute);
          },
          text: 'my list 1',
          icon: Icons.list,
          iconColor: MyTheme.blueColor,
          endNumber: 0,
        ),
        HomeItem(
          onTap: () {
            Navigator.of(context).pushNamed(taskListRoute);
          },
          text: 'my list 2',
          icon: Icons.list,
          iconColor: MyTheme.blueColor,
          endNumber: 0,
        )
      ],
    );
  }
}
