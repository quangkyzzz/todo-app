import 'dart:core';

class Settings {
  bool isAddNewTaskOnTop;
  bool isMoveStarTaskToTop;
  bool isPlaySoundOnComplete;
  bool isConfirmBeforeDelete;
  bool isShowDueToday;

  Settings({
    required this.isAddNewTaskOnTop,
    required this.isMoveStarTaskToTop,
    required this.isPlaySoundOnComplete,
    required this.isConfirmBeforeDelete,
    required this.isShowDueToday,
  });

  Settings copyWith({
    bool? isAddNewTaskOnTop,
    bool? isMoveStarTaskToTop,
    bool? isPlaySoundOnComplete,
    bool? isConfirmBeforeDelete,
    bool? isShowDueToday,
  }) {
    return Settings(
      isAddNewTaskOnTop: isAddNewTaskOnTop ?? this.isAddNewTaskOnTop,
      isMoveStarTaskToTop: isMoveStarTaskToTop ?? this.isMoveStarTaskToTop,
      isPlaySoundOnComplete:
          isPlaySoundOnComplete ?? this.isPlaySoundOnComplete,
      isConfirmBeforeDelete:
          isConfirmBeforeDelete ?? this.isConfirmBeforeDelete,
      isShowDueToday: isShowDueToday ?? this.isShowDueToday,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'isAddNewTaskOnTop': isAddNewTaskOnTop});
    result.addAll({'isMoveStarTaskToTop': isMoveStarTaskToTop});
    result.addAll({'isPlaySoundOnComplete': isPlaySoundOnComplete});
    result.addAll({'isConfirmBeforeDelete': isConfirmBeforeDelete});
    result.addAll({'isShowDueToday': isShowDueToday});
    return result;
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      isAddNewTaskOnTop: map['isAddNewTaskOnTop'],
      isMoveStarTaskToTop: map['isMoveStarTaskToTop'],
      isPlaySoundOnComplete: map['isPlaySoundOnComplete'],
      isConfirmBeforeDelete: map['isConfirmBeforeDelete'],
      isShowDueToday: map['isShowDueToday'],
    );
  }
}
