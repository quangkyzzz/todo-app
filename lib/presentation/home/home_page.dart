// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo_app/app_configs.dart';
import 'package:todo_app/models/group_model.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/presentation/home/home_group.dart';
import 'package:todo_app/presentation/home/home_item.dart';

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
    //fake data
    UserModel user = UserModel(
      id: '1',
      userName: 'Quang Nguyễn',
      userEmail: 'quang.ndt@outlook.com',
    );
    List<TaskListModel> taskLists = [
      TaskListModel(id: '1', listName: 'my personal list 1'),
      TaskListModel(id: '1', listName: 'my personal list 2'),
    ];
    List<GroupModel> groups = const [
      GroupModel(
        id: '1',
        groupName: 'Group 1',
        taskLists: [
          TaskListModel(
            id: '1',
            listName: 'my list 1',
          ),
          TaskListModel(
            id: '2',
            listName: 'my list 2',
          ),
        ],
      ),
      GroupModel(
        id: '2',
        groupName: 'Group 2',
        taskLists: [
          TaskListModel(
            id: '1',
            listName: 'my list 1',
          ),
          TaskListModel(
            id: '2',
            listName: 'my list 2',
          ),
        ],
      ),
    ];
    //fake data
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
      appBar: HomeAppBar(context: context, user: user).appBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 8, right: 6),
        child: Column(
          children: [
            //default list
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
            MyTheme.dividerWhiteStyle,
            //personal list
            Column(
              children: taskLists.map((item) {
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
            ),
            //personal group
            Column(
              children: groups.map((item) {
                return HomeGroup(group: item);
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 352,
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
                    SizedBox(width: 8),
                    Text(
                      'New list',
                      style: MyTheme.itemGreyTextStyle,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 6),
            IconButton(
              onPressed: () {
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
              icon: Icon(
                Icons.post_add,
                color: MyTheme.greyColor,
                size: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeAppBar {
  UserModel user;
  BuildContext context;
  HomeAppBar({
    Key? key,
    required this.context,
    required this.user,
  });

  AppBar appBar() {
    return AppBar(
      leading: Container(
        padding: EdgeInsets.only(left: 6),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(userProfileRoute);
          },
          child: const CircleAvatar(
            backgroundImage: AssetImage(AppConfigs.avatarImage),
            radius: 16.0,
          ),
        ),
      ),
      title: Container(
        width: double.infinity,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(userProfileRoute);
          },
          child: RichText(
            text: TextSpan(
              text: user.userName,
              style: MyTheme.titleTextStyle,
              children: [
                TextSpan(
                  text: '\n${user.userEmail}',
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
            size: 42,
            color: MyTheme.greyColor,
          ),
        ),
        SizedBox(width: 8)
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
