import 'package:flutter/material.dart';
import '../models/settings_model.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsModel settings = SettingsModel(
    isAddNewTaskOnTop: true,
    isMoveStarTaskToTop: true,
    isPlaySoundOnComplete: true,
    isConfirmBeforeDelete: true,
    isShowDueToday: true,
  );

  void updateSettingWith({
    bool? isAddNewTaskOnTop,
    bool? isMoveStarTaskToTop,
    bool? isPlaySoundOnComplete,
    bool? isConfirmBeforeDelete,
    bool? isShowDueToday,
  }) {
    settings = settings.copyWith(
      isAddNewTaskOnTop: isAddNewTaskOnTop,
      isMoveStarTaskToTop: isMoveStarTaskToTop,
      isPlaySoundOnComplete: isPlaySoundOnComplete,
      isConfirmBeforeDelete: isConfirmBeforeDelete,
      isShowDueToday: isShowDueToday,
    );

    notifyListeners();
  }
}
