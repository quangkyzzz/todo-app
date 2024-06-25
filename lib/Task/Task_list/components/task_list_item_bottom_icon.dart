import 'package:flutter/material.dart';
import 'package:todo_app/app_configs.dart';

class ItemIcon extends StatelessWidget {
  final String? text;
  final IconData? icon;
  const ItemIcon({
    super.key,
    this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ((text != null)
        ? Text(
            text!,
            style: const TextStyle(color: AppConfigs.greyColor),
          )
        : Icon(
            icon,
            size: 15,
            color: AppConfigs.greyColor,
          ));
  }
}
