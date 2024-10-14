import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceWithCacheService {
  static late SharedPreferencesWithCache pref;
  Future<void> init() async {
    pref = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
  }
}
