import 'package:flutter/material.dart';
import 'package:todo_app/Constant/routes.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/Home/components/home_item.dart';

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
      title: const Text('Group 1'),
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
          Icon(isExpanded ? Icons.more_vert : null),
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
          iconColor: AppConfigs.blueColor,
          endNumber: 0,
        ),
        HomeItem(
          onTap: () {
            Navigator.of(context).pushNamed(taskListRoute);
          },
          text: 'my list 2',
          icon: Icons.list,
          iconColor: AppConfigs.blueColor,
          endNumber: 0,
        )
      ],
    );
  }
}
