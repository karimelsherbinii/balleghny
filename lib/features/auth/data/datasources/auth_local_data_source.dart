import 'dart:convert';
import 'package:ballaghny/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/cache_helper.dart';
import '../../../../core/utils/app_strings.dart';

abstract class AuthLocalDataSource {
  Future<bool> saveLoginCredentials({required UserModel userModel});
  Future<UserModel?> getSavedLoginCredentials();
  Future<bool> logoutLocally();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> getSavedLoginCredentials() async {
    if (sharedPreferences.getString(AppStrings.user) != null) {
      var userData =
          await json.decode(sharedPreferences.getString(AppStrings.user)!);
      return UserModel.fromJson(userData);
    } else {
      return null;
    }
  }

  @override
  Future<bool> saveLoginCredentials({required UserModel userModel}) async =>
      sharedPreferences.setString(AppStrings.user, json.encode(userModel));

  @override
  Future<bool> logoutLocally() async {
    CacheHelper.clearData();
    return sharedPreferences.remove(AppStrings.user);
  }
}
