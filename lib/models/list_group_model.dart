import 'package:flutter/foundation.dart';
import 'dart:core';

@immutable
class ListGroupModel {
  final String groupID;
  final String groupName;

  const ListGroupModel({required this.groupID, required this.groupName});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'groupID': groupID});
    result.addAll({'groupName': groupName});

    return result;
  }

  factory ListGroupModel.fromMap(Map<String, dynamic> map) {
    return ListGroupModel(
      groupID: map['groupID'] ?? '-1',
      groupName: map['groupName'] ?? 'Untitle group',
    );
  }
}
