import 'package:ballaghny/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<bool> changeDarkMode({required bool isDark});
  Future<bool> getSavedDarkMode();
}

class SettingsLocalDataSourceImplementation implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;
  SettingsLocalDataSourceImplementation({required this.sharedPreferences});
  @override
  Future<bool> changeDarkMode({required bool isDark}) async =>
      await sharedPreferences.setBool(AppStrings.isDarkKey, isDark);

  @override
  Future<bool> getSavedDarkMode() async =>
      sharedPreferences.containsKey(AppStrings.isDarkKey)
          ? sharedPreferences.getBool(AppStrings.isDarkKey)!
          : AppStrings.isNotDark;
}
