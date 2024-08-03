import 'package:flutter/material.dart';
import 'package:todo_app/models/settings_model.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsModel settings = SettingsModel(
    isAddNewTask: true,
    isMoveToTop: true,
    isPlaySoundOnComplete: true,
    isConfirmBeforeDelete: true,
    isShowDueToday: true,
  );

  void updateSettingWith({
    bool? isAddNewTask,
    bool? isMoveToTop,
    bool? isPlaySoundOnComplete,
    bool? isConfirmBeforeDelete,
    bool? isShowDueToday,
  }) {
    settings = settings.copyWith(
      isAddNewTask: isAddNewTask,
      isMoveToTop: isMoveToTop,
      isPlaySoundOnComplete: isPlaySoundOnComplete,
      isConfirmBeforeDelete: isConfirmBeforeDelete,
      isShowDueToday: isShowDueToday,
    );

    notifyListeners();
  }
}
