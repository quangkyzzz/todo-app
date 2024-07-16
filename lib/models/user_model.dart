import 'dart:core';

class UserModel {
  final String id;
  String userName;
  String userEmail;
  //final List<TaskListModel>? taskLists;
  //final List<GroupModel>? groups;

  UserModel({
    required this.id,
    required this.userName,
    required this.userEmail,
    //this.taskLists,
    //this.groups,
  });

  UserModel copyWith({
    String? id,
    String? userName,
    String? userEmail,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userName': userName});
    result.addAll({'userEmail': userEmail});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '-1',
      userName: map['userName'] ?? 'Unknown name',
      userEmail: map['userEmail'] ?? 'Unknown email',
    );
  }
}
