// ignore_for_file: sized_box_for_whitespace
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';

class ChangeThemeBottomSheet extends StatefulWidget {
  final TaskListModel taskList;
  const ChangeThemeBottomSheet({super.key, required this.taskList});

  @override
  State<ChangeThemeBottomSheet> createState() => _ChangeThemeBottomSheetState();
}

class _ChangeThemeBottomSheetState extends State<ChangeThemeBottomSheet> {
  late int _page;
  late Color _selectedColor;
  late int _selectedImage;
  late TaskListProvider taskListProvider;

  onColorChange(Color value) {
    setState(() {
      _selectedColor = value;
    });
    TaskListModel newTaskList = widget.taskList.copyWith(themeColor: value);
    taskListProvider.updateTaskList(
      taskListID: widget.taskList.id,
      newTaskList: newTaskList,
    );
  }

  onImageChange(int value) {
    setState(() {
      _selectedImage = value;
    });
    TaskListModel newTaskList = widget.taskList.copyWith(
      backgroundImage: MyTheme.imageList[value],
      isDefaultImage: value,
    );
    taskListProvider.updateTaskList(
      taskListID: widget.taskList.id,
      newTaskList: newTaskList,
    );
  }

  onPickFile() async {}

  onClean() {
    setState(() {
      _selectedImage = -1;
    });
    TaskListModel newTaskList = widget.taskList.copyWith(
      isDefaultImage: -1,
    );
    newTaskList.backgroundImage = null;
    taskListProvider.updateTaskList(
      taskListID: widget.taskList.id,
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
    taskListProvider = Provider.of<TaskListProvider>(context, listen: false);
    _page = 0;
    _selectedColor = widget.taskList.themeColor;
    _selectedImage = widget.taskList.isDefaultImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 146,
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
                  : Row(
                      children: [
                        CustomOutlinedButton(
                          isHighLighted: false,
                          onTap: onClean,
                          text: 'Clean',
                        ),
                        const SizedBox(width: 6),
                        CustomOutlinedButton(
                          isHighLighted: ((_selectedImage == -1) &&
                              (widget.taskList.backgroundImage != null)),
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: [
                                'jpg',
                                'png',
                              ],
                            );
                            if (result != null) {
                              String resultPath = result.files.single.path!;
                              TaskListModel newTaskList =
                                  widget.taskList.copyWith(
                                backgroundImage: resultPath,
                                isDefaultImage: -1,
                              );
                              taskListProvider.updateTaskList(
                                taskListID: widget.taskList.id,
                                newTaskList: newTaskList,
                              );
                              setState(() {
                                _selectedImage = -1;
                              });
                            }
                          },
                          text: 'Custom',
                        ),
                        ...MyTheme.imageList.map((imgPath) {
                          return SelectImageButton(
                            imgPath: imgPath,
                            onTap: () {
                              onImageChange(MyTheme.imageList.indexOf(imgPath));
                            },
                            isHighLighted: (_selectedImage ==
                                MyTheme.imageList.indexOf(imgPath)),
                          );
                        })
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
