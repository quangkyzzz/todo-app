// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo_app/Constant/routes.dart';
import 'package:todo_app/theme/theme.dart';

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
          backgroundImage: AssetImage('assets/images/avatar.jpg'),
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: '\nquang.ndt@outlook.com',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: AppConfigs.greyColor),
                  )
                ]),
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(searchRoute);
          },
          child: const Icon(
            Icons.search,
            size: 40,
            color: AppConfigs.greyColor,
          ),
        ),
      ],
    );
  }
}
