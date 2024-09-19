import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../models/task_list.dart';
import '../../models/task.dart';
import '../../ultility/type_def.dart';
import '../../view_models/task_map_view_model.dart';
import '../items/task_list_item.dart';
import '../../themes.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSpeechEnable = false;
  SpeechToText speechToText = SpeechToText();
  TaskMapList searchTasks = [];
  bool isHideCompletedTask = false;
  String searchName = '';
  late TextEditingController _controller;

  void onSearchChange(String value) {
    setState(() {
      searchName = value;
    });
  }

  void onSpeechToTextResult(SpeechRecognitionResult result) {
    setState(() {
      isSpeechEnable = false;
      _controller.text = result.recognizedWords;
      onSearchChange(_controller.text);
    });
  }

  @override
  void initState() {
    // ignore: discarded_futures
    speechToText.initialize();
    searchTasks = context.read<TaskMapViewModel>().allTask;
    _controller = TextEditingController();
    super.initState();
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
            onPressed: () async {
              if (!isSpeechEnable) {
                _controller.clear();
                if (!isSpeechEnable) {
                  setState(() {
                    isSpeechEnable = true;
                  });
                  await speechToText.listen(
                    listenOptions: SpeechListenOptions(
                      listenMode: ListenMode.search,
                      cancelOnError: 1,
                    ),
                    onResult: onSpeechToTextResult,
                    listenFor: const Duration(seconds: 5),
                  );
                  Future.delayed(const Duration(seconds: 5), () {
                    setState(() {
                      isSpeechEnable = false;
                    });
                  });
                } else {
                  setState(() {
                    isSpeechEnable = false;
                  });
                }
              } else {
                await speechToText.cancel();
                setState(() {
                  isSpeechEnable = false;
                });
              }
            },
            icon: (!isSpeechEnable)
                ? const Icon(Icons.mic_outlined)
                : const Icon(Icons.mic_off),
          ),
          const SizedBox(width: 8),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isHideCompletedTask = !isHideCompletedTask;
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
                          ),
                  ),
                )
              ];
            },
          ),
        ],
      ),
      body: (isSpeechEnable)
          ? const Center(
              child: Text(
                'Say keyword to search!',
                style: MyTheme.itemTextStyle,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.only(top: 16),
              child: Consumer<TaskMapViewModel>(
                builder: (_, taskMapViewModel, child) {
                  searchTasks = taskMapViewModel.searchTaskByName(
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
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: searchTasks.length,
                      itemBuilder: (BuildContext _, int index) {
                        Map<Task, TaskList> item = searchTasks[index];
                        if (isHideCompletedTask) {
                          if (!item.keys.first.isCompleted) {
                            return TaskListItem(
                              mContext: context,
                              task: item.keys.first,
                              taskList: item.values.first,
                              themeColor: MyTheme.blueColor,
                              onTapCheck: (bool? value) {
                                context.read<TaskMapViewModel>().updateTaskWith(
                                      taskID: item.keys.first.id,
                                      isCompleted: value,
                                    );
                              },
                              onTapStar: () {
                                context.read<TaskMapViewModel>().updateTaskWith(
                                      taskID: item.keys.first.id,
                                      isImportant: !item.keys.first.isImportant,
                                    );
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        } else {
                          return TaskListItem(
                            mContext: context,
                            task: item.keys.first,
                            taskList: item.values.first,
                            themeColor: MyTheme.blueColor,
                            onTapCheck: (bool? value) {
                              context.read<TaskMapViewModel>().updateTaskWith(
                                    taskID: item.keys.first.id,
                                    isCompleted: value,
                                  );
                            },
                            onTapStar: () {
                              context.read<TaskMapViewModel>().updateTaskWith(
                                    taskID: item.keys.first.id,
                                    isImportant: !item.keys.first.isImportant,
                                  );
                            },
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
    );
  }
}
