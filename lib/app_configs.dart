import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';

class AppConfigs {
  //divider style
  static const Divider dividerGreyStyle = Divider(
    thickness: 0.25,
    color: MyTheme.greyColor,
  );
  static const Divider dividerWhiteStyle = Divider(
    thickness: 0.25,
    color: MyTheme.whiteColor,
  );

  //assets path
  static const String avatarImage = 'assets/avatars/avatar.jpg';
  static const String backGroundImage = 'assets/backgrounds/bg_my_day.jpg';
}
