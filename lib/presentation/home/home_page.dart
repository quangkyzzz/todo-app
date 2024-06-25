// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/home/home_group.dart';
import 'package:todo_app/home/home_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isExpanded = false;
  onTapMyDay(BuildContext context) {
    Navigator.of(context).pushNamed(myDayRoute);
  }

  onTapImportant(BuildContext context) {
    Navigator.of(context).pushNamed(taskListRoute, arguments: false);
  }

  onTapPlanned(BuildContext context) {
    Navigator.of(context).pushNamed(plannedRoute);
  }

  onTapAssignToMe(BuildContext context) {
    Navigator.of(context).pushNamed(taskListRoute);
  }

  onTapFlaggedEmail(BuildContext context) {
    Navigator.of(context).pushNamed(flaggedRoute);
  }

  onTapTask(BuildContext context) {
    Navigator.of(context).pushNamed(taskListRoute);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listHomeItem = [
      {
        'text': 'My Day',
        'ontap': onTapMyDay,
        'icon': Icons.wb_sunny_outlined,
        'iconColor': MyTheme.greyColor,
        'endNumber': 0
      },
      {
        'text': 'Important',
        'ontap': onTapImportant,
        'icon': Icons.star_border,
        'iconColor': MyTheme.pinkColor,
        'endNumber': 1,
      },
      {
        'text': 'Planned',
        'ontap': onTapPlanned,
        'icon': Icons.list_alt_outlined,
        'iconColor': MyTheme.redColor,
        'endNumber': 1,
      },
      {
        'text': 'Assign to me',
        'ontap': onTapAssignToMe,
        'icon': Icons.person_outline,
        'iconColor': MyTheme.greenColor,
        'endNumber': 1,
      },
      {
        'text': 'Flagged email',
        'ontap': onTapFlaggedEmail,
        'icon': Icons.flag_outlined,
        'iconColor': MyTheme.orangeColor,
        'endNumber': 0,
      },
      {
        'text': 'Tasks',
        'ontap': onTapTask,
        'icon': Icons.task_outlined,
        'iconColor': MyTheme.blueColor,
        'endNumber': 1,
      },
    ];
    return Scaffold(
      appBar: HomeAppBar(context: context).appBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 7, right: 5),
        child: Column(
          children: [
            Column(
              children: listHomeItem.map((item) {
                return HomeItem(
                  text: item['text'],
                  icon: item['icon'],
                  iconColor: item['iconColor'],
                  endNumber: item['endNumber'],
                  onTap: () {
                    item['ontap'](context);
                  },
                );
              }).toList(),
            ),
            AppConfigs.dividerWhiteStyle,
            HomeItem(
              onTap: () {
                Navigator.of(context).pushNamed(taskListRoute);
              },
              text: 'Getting started',
              icon: Icons.list,
              iconColor: MyTheme.blueColor,
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
                      color: MyTheme.greyColor,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'New list',
                      style: MyTheme.itemGreyTextStyle,
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
                color: MyTheme.greyColor,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeAppBar {
  BuildContext context;
  HomeAppBar({Key? key, required this.context});

  AppBar appBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(userProfileRoute);
        },
        child: const CircleAvatar(
          backgroundImage: AssetImage(AppConfigs.avatarImage),
          radius: 15.0,
        ),
      ),
      title: Container(
        height: 50,
        width: 300,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(userProfileRoute);
          },
          child: RichText(
            text: const TextSpan(
              text: 'Quang Nguyen',
              style: MyTheme.titleTextStyle,
              children: [
                TextSpan(
                  text: '\nquang.ndt@outlook.com',
                  style: MyTheme.secondaryTitleGreyTextStyle,
                )
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(searchRoute);
          },
          icon: const Icon(
            Icons.search,
            size: 40,
            color: MyTheme.greyColor,
          ),
        ),
      ],
    );
  }
}

class HomeDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final String positiveButton;
  const HomeDialog({
    super.key,
    required this.title,
    required this.hintText,
    required this.positiveButton,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {},
          child: Text(positiveButton),
        )
      ],
    );
  }
}
