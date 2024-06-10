// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/theme/pallete.dart';
import 'package:todo_app/views/home/home_app_bar.dart';
import 'package:todo_app/views/home/home_group.dart';
import 'package:todo_app/views/home/home_item.dart';

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
      appBar: HomeAppBar.appBar(),
      body: Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 3,
        ),
        child: const Column(
          children: [
            HomeItem(
              icon: Icons.wb_sunny_outlined,
              text: 'My Day',
              iconColor: Pallete.greyColor,
            ),
            HomeItem(
              icon: Icons.star_border,
              text: 'Important',
              iconColor: Pallete.pinkColor,
            ),
            HomeItem(
              icon: Icons.list_alt_outlined,
              text: 'Planned',
              iconColor: Pallete.redColor,
            ),
            HomeItem(
              icon: Icons.person_outline,
              text: 'Assigned to me',
              iconColor: Pallete.greenColor,
            ),
            HomeItem(
              icon: Icons.flag_outlined,
              text: 'Flagged email',
              iconColor: Pallete.orangeColor,
            ),
            HomeItem(
              icon: Icons.task_outlined,
              text: 'Tasks',
              iconColor: Pallete.blueColor,
            ),
            Divider(
              thickness: 2,
            ),
            HomeItem(
              text: 'Getting started',
              icon: Icons.list,
              iconColor: Pallete.blueColor,
            ),
            HomeGroup(),
          ],
        ),
      ),
    );
  }
}
