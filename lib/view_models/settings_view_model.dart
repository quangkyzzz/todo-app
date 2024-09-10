import 'package:flutter/material.dart';

import '../models/settings_model.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsModel settings = SettingsModel(
    isAddNewTaskOnTop: true,
    isMoveStarTaskToTop: true,
    isPlaySoundOnComplete: true,
    isConfirmBeforeDelete: true,
    isShowDueToday: true,
  );
}
