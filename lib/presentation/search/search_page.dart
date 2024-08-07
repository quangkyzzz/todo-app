import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_list_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/themes.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<TaskModel, TaskListModel>> tasks = [];
  List<Map<TaskModel, TaskListModel>> searchTasks = [];
  bool isHideCompletedTask = false;
  String searchName = '';
  late TaskListProvider taskListProvider;
  late TextEditingController _controller;

  void onSearchChange(String value) {
    setState(() {
      searchName = value;
    });
  }

  @override
  void initState() {
    taskListProvider = Provider.of<TaskListProvider>(context, listen: false);
    searchTasks = taskListProvider.getAllTaskWithTaskList();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: MyTheme.backgroundGreyColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: _controller,
            style: MyTheme.itemTextStyle,
            decoration: const InputDecoration(hintText: 'Enter task name'),
            onChanged: onSearchChange,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic_outlined),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {},
            child: PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            isHideCompletedTask = !isHideCompletedTask;
                            searchTasks.removeWhere(
                              (element) => (element.keys.first.isCompleted),
                            );
                          });
                          Navigator.pop(context);
                        },
                        child: (isHideCompletedTask)
                            ? const Text(
                                'Show completed item',
                                style: MyTheme.itemTextStyle,
                              )
                            : const Text(
                                'Hide completed item',
                                style: MyTheme.itemTextStyle,
                              )),
                  )
                ];
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Consumer<TaskListProvider>(builder: (
          context,
          consumerTaskListProvider,
          child,
        ) {
          searchTasks = consumerTaskListProvider.searchTaskByName(
            searchName: searchName,
          );

          if (searchTasks.isEmpty) {
            return const Center(
              child: Text(
                'No match result!',
                style: MyTheme.itemTextStyle,
              ),
            );
          } else {
            return Column(
              children: searchTasks.map((e) {
                if (isHideCompletedTask) {
                  if (!e.keys.first.isCompleted) {
                    return TaskListItem(
                      task: e.keys.first,
                      taskList: e.values.first,
                      themeColor: MyTheme.blueColor,
                    );
                  } else {
                    return const SizedBox();
                  }
                } else {
                  return TaskListItem(
                    task: e.keys.first,
                    taskList: e.values.first,
                    themeColor: MyTheme.blueColor,
                  );
                }
              }).toList(),
            );
          }
        }),
      ),
    );
  }
}
