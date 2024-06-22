// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/constant/app_configs.dart';
import 'package:todo_app/constant/routes.dart';
import 'package:todo_app/home/components/home_app_bar.dart';
import 'package:todo_app/home/components/home_dialog.dart';
import 'package:todo_app/home/components/home_group.dart';
import 'package:todo_app/home/components/home_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isExpanded = false;
  onTapMyDay() {
    Navigator.of(context).pushNamed(myDayRoute);
  }

  onTapImportant() {
    Navigator.of(context).pushNamed(taskListRoute, arguments: false);
  }

  onTapPlanned() {
    Navigator.of(context).pushNamed(plannedRoute);
  }

  onTapAssignToMe() {
    Navigator.of(context).pushNamed(taskListRoute);
  }

  onTapFlaggedEmail() {
    Navigator.of(context).pushNamed(flaggedRoute);
  }

  onTapTask() {
    Navigator.of(context).pushNamed(taskListRoute);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listHomeItem = [
      {
        'text': 'My Day',
        'ontap': onTapMyDay,
        'icon': Icons.wb_sunny_outlined,
        'iconColor': AppConfigs.greyColor,
        'endNumber': 0
      },
      {
        'text': 'Important',
        'ontap': onTapImportant,
        'icon': Icons.star_border,
        'iconColor': AppConfigs.pinkColor,
        'endNumber': 1,
      },
      {
        'text': 'Planned',
        'ontap': onTapPlanned,
        'icon': Icons.list_alt_outlined,
        'iconColor': AppConfigs.redColor,
        'endNumber': 1,
      },
      {
        'text': 'Assign to me',
        'ontap': onTapAssignToMe,
        'icon': Icons.person_outline,
        'iconColor': AppConfigs.greenColor,
        'endNumber': 1,
      },
      {
        'text': 'Flagged email',
        'ontap': onTapFlaggedEmail,
        'icon': Icons.flag_outlined,
        'iconColor': AppConfigs.orangeColor,
        'endNumber': 0,
      },
      {
        'text': 'Tasks',
        'ontap': onTapTask,
        'icon': Icons.task_outlined,
        'iconColor': AppConfigs.blueColor,
        'endNumber': 1,
      },
    ];
    return Scaffold(
      appBar: HomeAppBar(context: context).appBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 7, right: 5),
        child: Column(
          children: [
            for (Map<String, dynamic> item in listHomeItem)
              HomeItem(
                text: item['text'],
                icon: item['icon'],
                iconColor: item['iconColor'],
                endNumber: item['endNumber'],
                onTap: item['ontap'],
              ),
            AppConfigs.dividerWhiteStyle,
            HomeItem(
              onTap: () {
                Navigator.of(context).pushNamed(taskListRoute);
              },
              text: 'Getting started',
              icon: Icons.list,
              iconColor: AppConfigs.blueColor,
              endNumber: 0,
            ),
            HomeGroup(),
            HomeGroup(),
            HomeGroup(),
            HomeGroup(),
            HomeGroup(),
            HomeGroup(),
            HomeGroup(),
            HomeGroup(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: 40,
              width: 370,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return HomeDialog(
                        title: 'New List',
                        hintText: 'Enter your list title',
                        positiveButton: 'Create list',
                      );
                    },
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: AppConfigs.greyColor,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'New list',
                      style: AppConfigs.itemGreyTextStyle,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 5),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return HomeDialog(
                        title: 'Create a group',
                        hintText: 'Name this group',
                        positiveButton: 'Create group',
                      );
                    });
              },
              child: Icon(
                Icons.post_add,
                color: AppConfigs.greyColor,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
