// ignore_for_file: sized_box_for_whitespace

import 'dart:io';
import 'package:flutter/material.dart';
import '../../../themes.dart';
import 'package:path/path.dart' as path;

class FileItem extends StatelessWidget {
  final String filePath;
  final Function() onClose;
  final Function() onTap;
  const FileItem({
    super.key,
    required this.filePath,
    required this.onClose,
    required this.onTap,
  });

  String fileSizeConvert(int size) {
    double convertedSize = size / 1024;
    if (convertedSize < 1024) {
      return '${convertedSize.toStringAsFixed(2)} KB';
    } else if (convertedSize < 1024 * 1024) {
      return '${(convertedSize / 1024).toStringAsFixed(2)} MB';
    } else if (convertedSize < 1024 * 1024 * 1024) {
      return '${(convertedSize / (1024 * 1024)).toStringAsFixed(2)} GB';
    } else {
      return '${(convertedSize / (1024 * 1024)).toStringAsFixed(2)} GB';
    }
  }

  @override
  Widget build(BuildContext context) {
    File file = File(filePath);
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 2, left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: MyTheme.blueColor,
                borderRadius: BorderRadius.circular(8),
              ),
              width: screenWidth * 0.12,
              height: screenWidth * 0.12,
              child: Center(
                child: Text(
                  path.extension(filePath).substring(1),
                  style: MyTheme.itemSmallTextStyle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onTap,
            child: Container(
              width: screenWidth * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    path.basename(filePath),
                    style: MyTheme.itemSmallTextStyle,
                  ),
                  Text(
                    fileSizeConvert(file.lengthSync()),
                    style: MyTheme.itemExtraSmallGreyTextStyle,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.close_outlined,
            ),
            iconSize: 16,
            color: MyTheme.greyColor,
            onPressed: onClose,
          )
        ],
      ),
    );
  }
}
