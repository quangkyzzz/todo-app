import 'package:flutter/foundation.dart';
import 'dart:core';

@immutable
class UserModel {
  final String userID;
  final String userName;
  final String userEmail;

  const UserModel({
    required this.userID,
    required this.userName,
    required this.userEmail,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userID': userID});
    result.addAll({'userName': userName});
    result.addAll({'userEmail': userEmail});
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'] ?? '-1',
      userName: map['userName'] ?? 'Unknow user',
      userEmail: map['userEmail'] ?? 'Unknow email',
    );
  }
}
