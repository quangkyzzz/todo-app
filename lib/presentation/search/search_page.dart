import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/view_models/task_list_view_model.dart';
import 'package:todo_app/presentation/items/task_list_item.dart';
import 'package:todo_app/themes.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSpeechEnable = false;
  SpeechToText speechToText = SpeechToText();
  late List<Task> searchResult;
  bool isHideCompletedTask = false;
  String searchName = '';
  late TextEditingController _controller;

  @override
  void initState() {
    context.read<TaskListViewModel>().getAllTask();
    // ignore: discarded_futures
    speechToText.initialize();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchResult = context.watch<TaskListViewModel>().searchTaskByName(
          searchName: searchName,
          isHideCompleted: isHideCompletedTask,
        );
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
            onChanged: (String value) {
              setState(() {
                searchName = value;
              });
            },
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
                    onResult: (SpeechRecognitionResult result) {
                      setState(() {
                        isSpeechEnable = false;
                        _controller.text = result.recognizedWords;
                        setState(() {
                          searchName = _controller.text;
                        });
                      });
                    },
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
              child: Builder(
                builder: (_) {
                  if (searchResult.isEmpty) {
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
                      itemCount: searchResult.length,
                      itemBuilder: (BuildContext _, int index) {
                        Task task = searchResult[index];
                        if (isHideCompletedTask) {
                          if (!task.isCompleted) {
                            return TaskListItem(
                              task: task,
                              themeColor: MyTheme.blueColor,
                            );
                          } else {
                            return const SizedBox();
                          }
                        } else {
                          return TaskListItem(
                            task: task,
                            themeColor: MyTheme.blueColor,
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
