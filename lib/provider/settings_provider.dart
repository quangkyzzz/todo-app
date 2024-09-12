import 'package:flutter/material.dart';
import '../models/settings.dart';

class SettingsProvider extends ChangeNotifier {
  Settings settings = Settings(
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
