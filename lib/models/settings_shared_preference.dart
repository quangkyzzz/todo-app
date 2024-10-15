import 'package:shared_preferences/shared_preferences.dart';

class SettingsSharedPreference {
  static late SharedPreferencesWithCache pref;

  static Future<void> init() async {
    pref = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
  }

  static bool getIsAddNewTaskOnTop() {
    return pref.getBool('isAddNewTaskOnTop') ?? true;
  }

  static bool getIsMoveStarTaskToTop() {
    return pref.getBool('isMoveStarTaskToTop') ?? true;
  }

  static bool getIsPlaySoundOnComplete() {
    return pref.getBool('isPlaySoundOnComplete') ?? true;
  }

  static bool getIsConfirmBeforeDelete() {
    return pref.getBool('isConfirmBeforeDelete') ?? true;
  }

  static bool getIsShowDueToday() {
    return pref.getBool('isShowDueToday') ?? true;
  }

  static void setIsAddNewTaskOnTop(bool value) async {
    pref.setBool('isAddNewTaskOnTop', value);
  }

  static void setIsMoveStarTaskToTop(bool value) async {
    pref.setBool('isMoveStarTaskToTop', value);
  }

  static void setIsPlaySoundOnComplete(bool value) async {
    pref.setBool('isPlaySoundOnComplete', value);
  }

  static void setIsConfirmBeforeDelete(bool value) async {
    pref.setBool('isConfirmBeforeDelete', value);
  }

  static void setIsShowDueToday(bool value) async {
    pref.setBool('isShowDueToday', value);
  }
}
