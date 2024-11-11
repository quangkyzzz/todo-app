import 'dart:core';

class User {
  final String id;
  String userName;
  String userEmail;

  User({
    required this.id,
    required this.userName,
    required this.userEmail,
  });

  User copyWith({
    String? id,
    String? userName,
    String? userEmail,
  }) {
    return User(
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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '-1',
      userName: map['userName'] ?? 'Unknown name',
      userEmail: map['userEmail'] ?? 'Unknown email',
    );
  }
}
