// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/Constant/app_configs.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(context: context).appBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 7, right: 5),
        child: const Column(
          children: [
            HomeItem(
              icon: Icons.wb_sunny_outlined,
              text: 'My Day',
              iconColor: AppConfigs.greyColor,
              endNumber: 0,
            ),
            HomeItem(
              icon: Icons.star_border,
              text: 'Important',
              iconColor: AppConfigs.pinkColor,
              endNumber: 1,
            ),
            HomeItem(
              icon: Icons.list_alt_outlined,
              text: 'Planned',
              iconColor: AppConfigs.redColor,
              endNumber: 2,
            ),
            HomeItem(
              icon: Icons.person_outline,
              text: 'Assigned to me',
              iconColor: AppConfigs.greenColor,
              endNumber: 3,
            ),
            HomeItem(
              icon: Icons.flag_outlined,
              text: 'Flagged email',
              iconColor: AppConfigs.orangeColor,
              endNumber: 0,
            ),
            HomeItem(
              icon: Icons.task_outlined,
              text: 'Tasks',
              iconColor: AppConfigs.blueColor,
              endNumber: 0,
            ),
            Divider(
              thickness: 2,
            ),
            HomeItem(
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
              onTap: () {},
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
                    style: TextStyle(color: AppConfigs.greyColor, fontSize: 25),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 5),
          InkWell(
            onTap: () {},
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
