// ignore_for_file: discarded_futures

import 'package:shared_preferences/shared_preferences.dart';

class SettingsSharedPreference {
  late final SharedPreferencesWithCache pref;
  SettingsSharedPreference._internalConstructor() {
    _initPref();
  }
  static final SettingsSharedPreference _settingSharedPreference =
      SettingsSharedPreference._internalConstructor();

  static SettingsSharedPreference get getInstance => _settingSharedPreference;

  Future<void> _initPref() async {
    pref = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
  }

  bool getIsAddNewTaskOnTop() {
    return pref.getBool('isAddNewTaskOnTop') ?? true;
  }

  bool getIsMoveStarTaskToTop() {
    return pref.getBool('isMoveStarTaskToTop') ?? true;
  }

  bool getIsPlaySoundOnComplete() {
    return pref.getBool('isPlaySoundOnComplete') ?? true;
  }

  bool getIsConfirmBeforeDelete() {
    return pref.getBool('isConfirmBeforeDelete') ?? true;
  }

  bool getIsShowDueToday() {
    return pref.getBool('isShowDueToday') ?? true;
  }

  void setIsAddNewTaskOnTop(bool value) async {
    pref.setBool('isAddNewTaskOnTop', value);
  }

  void setIsMoveStarTaskToTop(bool value) async {
    pref.setBool('isMoveStarTaskToTop', value);
  }

  void setIsPlaySoundOnComplete(bool value) async {
    pref.setBool('isPlaySoundOnComplete', value);
  }

  void setIsConfirmBeforeDelete(bool value) async {
    pref.setBool('isConfirmBeforeDelete', value);
  }

  void setIsShowDueToday(bool value) async {
    pref.setBool('isShowDueToday', value);
  }
}
