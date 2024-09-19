// ignore_for_file: sized_box_for_whitespace
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task_list.dart';
import '../../themes.dart';
import '../../view_models/task_list_view_model.dart';

class ChangeThemeBottomSheet extends StatefulWidget {
  final TaskList taskList;
  final BuildContext mContext;
  const ChangeThemeBottomSheet({
    super.key,
    required this.taskList,
    required this.mContext,
  });

  @override
  State<ChangeThemeBottomSheet> createState() => _ChangeThemeBottomSheetState();
}

class _ChangeThemeBottomSheetState extends State<ChangeThemeBottomSheet> {
  late int _page;
  late Color _selectedColor;
  late int _selectedImage;
  late TaskListViewModel taskListViewModel;

  onColorChange(Color value) {
    setState(() {
      _selectedColor = value;
    });
    TaskList newTaskList = widget.taskList.copyWith(themeColor: value);
    taskListViewModel.updateTaskList(
      newTaskList: newTaskList,
    );
  }

  onImageChange(int value) {
    setState(() {
      _selectedImage = value;
    });
    TaskList newTaskList = widget.taskList.copyWith(
      backgroundImage: MyTheme.imageList[value],
      defaultImage: value,
    );
    taskListViewModel.updateTaskList(
      newTaskList: newTaskList,
    );
  }

  onPickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
      ],
    );
    if (result != null) {
      String resultPath = result.files.single.path!;
      TaskList newTaskList = widget.taskList.copyWith(
        backgroundImage: resultPath,
        defaultImage: -1,
      );
      taskListViewModel.updateTaskList(
        newTaskList: newTaskList,
      );
      setState(() {
        _selectedImage = -1;
      });
    }
  }

  onClean() {
    setState(() {
      _selectedImage = -1;
    });
    TaskList newTaskList = widget.taskList.copyWith(
      defaultImage: -1,
    );
    newTaskList.backgroundImage = null;
    taskListViewModel.updateTaskList(
      newTaskList: newTaskList,
    );
  }

  onPageChange(int value) {
    setState(() {
      _page = value;
    });
  }

  @override
  void initState() {
    _page = 0;
    _selectedColor = widget.taskList.themeColor;
    _selectedImage = widget.taskList.defaultImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    taskListViewModel =
        Provider.of<TaskListViewModel>(widget.mContext, listen: false);
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
                const SizedBox(width: 8),
                CustomOutlinedButton(
                  isHighLighted: (_page == 2),
                  onTap: () {
                    onPageChange(2);
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
                            onColorChange(color);
                          },
                          color: color,
                          isHighLighted: (_selectedColor == color),
                        );
                      }).toList(),
                    )
                  : (_page == 1)
                      ? Row(
                          children: [
                            CustomOutlinedButton(
                              isHighLighted: false,
                              onTap: onClean,
                              text: 'Clean',
                            ),
                            const SizedBox(width: 6),
                            ...MyTheme.imageList.map((imgPath) {
                              return SelectImageButton(
                                imgPath: imgPath,
                                onTap: () {
                                  onImageChange(
                                      MyTheme.imageList.indexOf(imgPath));
                                },
                                isHighLighted: (_selectedImage ==
                                    MyTheme.imageList.indexOf(imgPath)),
                              );
                            })
                          ],
                        )
                      : Row(
                          children: [
                            CustomOutlinedButton(
                              isHighLighted: false,
                              onTap: onClean,
                              text: 'Clean',
                            ),
                            IconButton(
                              onPressed: onPickFile,
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
