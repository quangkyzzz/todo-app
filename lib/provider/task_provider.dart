// import 'package:flutter/material.dart';
// import 'package:todo_app/models/step_model.dart';
// import 'package:todo_app/models/task_model.dart';

// class TaskProvider extends ChangeNotifier {
//   List<TaskModel> tasks = [
//     TaskModel(
//       id: '1',
//       title: 'Tasks',
//       isCompleted: false,
//       isImportant: false,
//       createDate: DateTime(2024, 6, 9),
//       stepList: [
//         StepModel(
//           id: '1',
//           stepName: 'step 1',
//           isCompleted: false,
//         ),
//         StepModel(
//           id: '2',
//           stepName: 'step 2',
//           isCompleted: true,
//         ),
//       ],
//     ),
//     TaskModel(
//       id: '2',
//       title: 'few day',
//       isCompleted: false,
//       isImportant: false,
//       createDate: DateTime(2024, 6, 2),
//       dueDate: DateTime(2024, 6, 2),
//       repeatFrequency: 'gg',
//     ),
//     TaskModel(
//       id: '3',
//       title: 'few hour',
//       isCompleted: false,
//       isImportant: false,
//       createDate: DateTime(2024, 7, 2, 7),
//     ),
//     TaskModel(
//       id: '4',
//       title: 'recent',
//       isCompleted: false,
//       isImportant: false,
//       createDate: DateTime(2024, 7, 2, 9, 38),
//     ),
//     TaskModel(
//       id: '5',
//       title: 'few minute',
//       isCompleted: false,
//       isImportant: false,
//       createDate: DateTime(2024, 7, 2, 9, 30),
//     ),
//   ];

//   void updateUserName(String newName) {
//     user = user.copyWith(userName: newName);
//     notifyListeners();
//   }

//   void updateUserEmail(String newEmail) {
//     user = user.copyWith(userEmail: newEmail);
//     notifyListeners();
//   }
// }
