import 'package:flutter/material.dart';

import '../models/settings.dart';

class SettingsViewModel extends ChangeNotifier {
  Settings settings = Settings(
    isAddNewTaskOnTop: true,
    isMoveStarTaskToTop: true,
    isPlaySoundOnComplete: true,
    isConfirmBeforeDelete: true,
    isShowDueToday: true,
  );
}
