import 'package:flutter/foundation.dart';
import 'dart:core';

@immutable
class ListModel {
  final String listID;
  final String listName;

  const ListModel({required this.listID, required this.listName});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'listID': listID});
    result.addAll({'listName': listName});

    return result;
  }

  factory ListModel.fromMap(Map<String, dynamic> map) {
    return ListModel(
      listID: map['listID'] ?? '-1',
      listName: map['listName'] ?? 'Untitle list',
    );
  }
}
