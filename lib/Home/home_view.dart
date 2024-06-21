// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';
import 'package:todo_app/Constant/routes.dart';
import 'package:todo_app/Home/components/home_app_bar.dart';
import 'package:todo_app/Home/components/home_group.dart';
import 'package:todo_app/Home/components/home_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isExpanded = false;
  void onTapToNormalList() {
    Navigator.of(context).pushNamed(taskListRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(context: context).appBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 7, right: 5),
        child: Column(
          children: [
            HomeItem(
              onTap: () {
                Navigator.of(context).pushNamed(myDayRoute);
              },
              icon: Icons.wb_sunny_outlined,
              text: 'My Day',
              iconColor: AppConfigs.greyColor,
              endNumber: 0,
            ),
            HomeItem(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(taskListRoute, arguments: false);
              },
              icon: Icons.star_border,
              text: 'Important',
              iconColor: AppConfigs.pinkColor,
              endNumber: 1,
            ),
            HomeItem(
              onTap: () {
                Navigator.of(context).pushNamed(plannedRoute);
              },
              icon: Icons.list_alt_outlined,
              text: 'Planned',
              iconColor: AppConfigs.redColor,
              endNumber: 2,
            ),
            HomeItem(
              onTap: () {
                onTapToNormalList();
              },
              icon: Icons.person_outline,
              text: 'Assigned to me',
              iconColor: AppConfigs.greenColor,
              endNumber: 3,
            ),
            HomeItem(
              onTap: () {
                Navigator.of(context).pushNamed(flaggedRoute);
              },
              icon: Icons.flag_outlined,
              text: 'Flagged email',
              iconColor: AppConfigs.orangeColor,
              endNumber: 0,
            ),
            HomeItem(
              onTap: () {
                onTapToNormalList();
              },
              icon: Icons.task_outlined,
              text: 'Tasks',
              iconColor: AppConfigs.blueColor,
              endNumber: 0,
            ),
            Divider(
              thickness: 2,
            ),
            HomeItem(
              onTap: () {
                onTapToNormalList();
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
      bottomNavigationBar: Row(
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
                      return AlertDialog(
                        title: Text('New List'),
                        content: TextField(
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'Enter your list title',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Create list'),
                          )
                        ],
                      );
                    });
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
                    return AlertDialog(
                      title: Text('Create a group'),
                      content: TextField(
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Name this group',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Create group'),
                        )
                      ],
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
    );
  }
}
