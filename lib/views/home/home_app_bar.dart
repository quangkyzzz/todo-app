import 'package:flutter/material.dart';
import 'package:todo_app/theme/theme.dart';

class HomeAppBar {
  static AppBar appBar() {
    return AppBar(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/avatar.jpg'),
        radius: 15.0,
      ),
      title: RichText(
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
                    color: Pallete.greyColor),
              )
            ]),
      ),
      actions: const [
        Icon(
          Icons.search,
          size: 40,
          color: Pallete.greyColor,
        ),
      ],
    );
  }
}
