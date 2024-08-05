// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:todo_app/themes.dart';

class ChangeThemeBottomSheet extends StatefulWidget {
  const ChangeThemeBottomSheet({super.key});

  @override
  State<ChangeThemeBottomSheet> createState() => _ChangeThemeBottomSheetState();
}

class _ChangeThemeBottomSheetState extends State<ChangeThemeBottomSheet> {
  int _page = 0;
  Color _selectedColor = MyTheme.whiteColor;

  onColorChange(Color value) {
    setState(() {
      _selectedColor = value;
    });
  }

  onPageChange(int value) {
    setState(() {
      _page = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pick a theme',
              style: MyTheme.itemTextStyle,
            ),
            Row(
              children: [
                CustomOutlinedButton(
                  isHighLighted: (_page == 0),
                  onTap: () {
                    onPageChange(0);
                  },
                  text: 'Color :',
                ),
                const SizedBox(width: 8),
                CustomOutlinedButton(
                  isHighLighted: (_page == 1),
                  onTap: () {
                    onPageChange(1);
                  },
                  text: 'Image :',
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: (_page == 0)
                  ? Row(
                      children: MyTheme.colorThemeList.map((color) {
                        return SelectColorButton(
                          onTap: () {
                            onColorChange(color);
                          },
                          color: color,
                          isHighLighted: (_selectedColor == color),
                        );
                      }).toList(),
                    )
                  : Text('image'),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectColorButton extends StatelessWidget {
  final Color color;
  final Function() onTap;
  final bool isHighLighted;
  const SelectColorButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.isHighLighted,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          shape: const CircleBorder(),
          side: (isHighLighted)
              ? const BorderSide(width: 8, color: MyTheme.blackColor)
              : null,
        ),
        child: Container(
          height: 50,
          width: 1,
        ));
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final bool isHighLighted;
  final Function() onTap;
  const CustomOutlinedButton({
    super.key,
    required this.isHighLighted,
    required this.onTap,
    required this.text,
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
      child: Text(
        text,
        style: MyTheme.itemSmallTextStyle,
      ),
    );
  }
}
