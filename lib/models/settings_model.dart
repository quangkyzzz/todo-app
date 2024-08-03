import 'dart:core';

class SettingsModel {
  bool isAddNewTask;
  bool isMoveToTop;
  bool isPlaySoundOnComplete;
  bool isConfirmBeforeDelete;
  bool isShowDueToday;

  SettingsModel({
    required this.isAddNewTask,
    required this.isMoveToTop,
    required this.isPlaySoundOnComplete,
    required this.isConfirmBeforeDelete,
    required this.isShowDueToday,
  });

  SettingsModel copyWith({
    bool? isAddNewTask,
    bool? isMoveToTop,
    bool? isPlaySoundOnComplete,
    bool? isConfirmBeforeDelete,
    bool? isShowDueToday,
  }) {
    return SettingsModel(
      isAddNewTask: isAddNewTask ?? this.isAddNewTask,
      isMoveToTop: isMoveToTop ?? this.isMoveToTop,
      isPlaySoundOnComplete:
          isPlaySoundOnComplete ?? this.isPlaySoundOnComplete,
      isConfirmBeforeDelete:
          isConfirmBeforeDelete ?? this.isConfirmBeforeDelete,
      isShowDueToday: isShowDueToday ?? this.isShowDueToday,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'isAddNewTask': isAddNewTask});
    result.addAll({'isMoveToTop': isMoveToTop});
    result.addAll({'isPlaySoundOnComplete': isPlaySoundOnComplete});
    result.addAll({'isConfirmBeforeDelete': isConfirmBeforeDelete});
    result.addAll({'isShowDueToday': isShowDueToday});
    return result;
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      isAddNewTask: map['isAddNewTask'],
      isMoveToTop: map['isMoveToTop'],
      isPlaySoundOnComplete: map['isPlaySoundOnComplete'],
      isConfirmBeforeDelete: map['isConfirmBeforeDelete'],
      isShowDueToday: map['isShowDueToday'],
    );
  }
}
