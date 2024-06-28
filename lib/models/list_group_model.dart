import 'package:flutter/foundation.dart';
import 'dart:core';

@immutable
class ListGroupModel {
  final String groupID;
  final String groupName;
  final List<String>? listTaskListID;

  const ListGroupModel({
    required this.groupID,
    required this.groupName,
    this.listTaskListID,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'groupID': groupID});
    result.addAll({'groupName': groupName});
    result.addAll({'listTaskListID': listTaskListID});
    return result;
  }

  factory ListGroupModel.fromMap(Map<String, dynamic> map) {
    return ListGroupModel(
      groupID: map['groupID'] ?? '-1',
      groupName: map['groupName'] ?? 'Untitle group',
      listTaskListID: map['listTaskListID'] ?? [],
    );
  }
}
