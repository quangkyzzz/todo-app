import '../../themes.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final bool isHighLighted;
  final Function() onTap;
  final String? highLightText;
  const CustomOutlinedButton({
    super.key,
    required this.isHighLighted,
    required this.onTap,
    required this.text,
    this.highLightText,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(width: 1, color: MyTheme.whiteColor),
        backgroundColor: (isHighLighted) ? MyTheme.lightGreyColor : null,
      ),
      child: (isHighLighted)
          ? Text(
              highLightText ?? text,
              style: MyTheme.itemSmallTextStyle,
            )
          : Text(
              text,
              style: MyTheme.itemSmallTextStyle,
            ),
    );
  }
}
