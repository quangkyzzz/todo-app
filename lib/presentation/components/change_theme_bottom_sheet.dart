// ignore_for_file: sized_box_for_whitespace
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/view_models/task_list_view_model.dart';
import 'package:todo_app/presentation/widgets/custom_outlined_button.dart';

class ChangeThemeBottomSheet extends StatefulWidget {
  const ChangeThemeBottomSheet({
    super.key,
  });

  @override
  State<ChangeThemeBottomSheet> createState() => _ChangeThemeBottomSheetState();
}

class _ChangeThemeBottomSheetState extends State<ChangeThemeBottomSheet> {
  late int _page;

  @override
  void initState() {
    _page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: screenHeight * 0.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Custom your theme',
              style: MyTheme.itemTextStyle,
            ),
            Row(
              children: [
                CustomOutlinedButton(
                  isHighLighted: (_page == 0),
                  onTap: () {
                    setState(() {
                      _page = 0;
                    });
                  },
                  text: 'Color :',
                ),
                const SizedBox(width: 8),
                CustomOutlinedButton(
                  isHighLighted: (_page == 1),
                  onTap: () {
                    setState(() {
                      _page = 1;
                    });
                  },
                  text: 'Image :',
                ),
                const SizedBox(width: 8),
                CustomOutlinedButton(
                  isHighLighted: (_page == 2),
                  onTap: () {
                    setState(() {
                      _page = 2;
                    });
                  },
                  text: 'Custom :',
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
                            context.read<TaskListViewModel>().updateThemeColor(
                                  themeColor: color,
                                );
                          },
                          color: color,
                          isHighLighted: (context
                                  .watch<TaskListViewModel>()
                                  .currentTaskList
                                  .themeColor ==
                              color),
                        );
                      }).toList(),
                    )
                  : (_page == 1)
                      ? Row(
                          children: [
                            CustomOutlinedButton(
                              isHighLighted: false,
                              onTap: () {
                                TaskList updatedTaskList = context
                                    .read<TaskListViewModel>()
                                    .currentTaskList;
                                updatedTaskList.defaultImage = -1;
                                updatedTaskList.backgroundImage = null;
                                context
                                    .read<TaskListViewModel>()
                                    .updateBackGroundImage(
                                      backGroundImage: null,
                                      defaultImage: -1,
                                    );
                              },
                              text: 'Clean',
                            ),
                            const SizedBox(width: 6),
                            ...MyTheme.imageList.map((imgPath) {
                              return SelectImageButton(
                                imgPath: imgPath,
                                onTap: () {
                                  context
                                      .read<TaskListViewModel>()
                                      .updateBackGroundImage(
                                        backGroundImage: imgPath,
                                        defaultImage:
                                            MyTheme.imageList.indexOf(imgPath),
                                      );
                                },
                                isHighLighted: (context
                                        .watch<TaskListViewModel>()
                                        .currentTaskList
                                        .defaultImage ==
                                    MyTheme.imageList.indexOf(imgPath)),
                              );
                            })
                          ],
                        )
                      : Row(
                          children: [
                            CustomOutlinedButton(
                              isHighLighted: false,
                              onTap: () {
                                context
                                    .read<TaskListViewModel>()
                                    .updateBackGroundImage(
                                      backGroundImage: null,
                                      defaultImage: -1,
                                    );
                              },
                              text: 'Clean',
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: [
                                    'jpg',
                                    'png',
                                  ],
                                );
                                if (!context.mounted) return;
                                if (result != null) {
                                  String resultPath = result.files.single.path!;
                                  context
                                      .read<TaskListViewModel>()
                                      .updateBackGroundImage(
                                        backGroundImage: resultPath,
                                        defaultImage: -1,
                                      );
                                }
                              },
                              icon: const Icon(Icons.add_outlined),
                            )
                          ],
                        ),
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
        fixedSize: const Size(50, 50),
        backgroundColor: color,
        shape: const CircleBorder(),
      ),
      child: (isHighLighted)
          ? const Icon(
              Icons.check_circle_outline,
              color: MyTheme.blackColor,
              size: 32,
            )
          : null,
    );
  }
}

class SelectImageButton extends StatelessWidget {
  final String imgPath;
  final Function() onTap;
  final bool isHighLighted;
  const SelectImageButton({
    super.key,
    required this.imgPath,
    required this.onTap,
    required this.isHighLighted,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const CircleBorder(),
      height: 50,
      minWidth: 50,
      visualDensity: const VisualDensity(horizontal: -3),
      onPressed: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imgPath),
            radius: 24,
          ),
          (isHighLighted)
              ? const Center(
                  child: Icon(
                    Icons.check_circle_outline,
                    color: MyTheme.whiteColor,
                    size: 32,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
