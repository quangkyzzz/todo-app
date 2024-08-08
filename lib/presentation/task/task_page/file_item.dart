import 'dart:io';

import 'package:flutter/material.dart';

class FileItem extends StatelessWidget {
  final String filePath;
  const FileItem({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    File file = File(filePath);

    return Row(
      children: [
        Column(
          children: [
            Flexible(
              child: Text(
                file.toString(),
              ),
            )
          ],
        ),
        const Icon(Icons.close)
      ],
    );
  }
}
