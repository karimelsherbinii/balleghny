import 'dart:developer';

import 'package:ballaghny/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ballaghny/core/api/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_strings.dart';
import '../../features/splash/data/datasources/lang_local_data_source.dart';

class AppIntercepters extends Interceptor {
  final LangLocalDataSource langLocalDataSource;
  AppIntercepters({
    required this.langLocalDataSource,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers[AppStrings.contentType] = AppStrings.applicationJson;
    options.headers[AppStrings.accept] = AppStrings.applicationJson;
    options.headers[AppStrings.xRequested] = AppStrings.xmlHttpRequest;
    final sharedPreferences = await SharedPreferences.getInstance();

    options.headers[AppStrings.authorization] =
        sharedPreferences.getString(AppStrings.token) ?? '';
    // this is removed
    // CacheHelper.getData(key: AppStrings.token);

    String lang = CacheHelper.getData(key: AppStrings.locale) ?? 'ar';
    options.headers[AppStrings.lang] = lang;

    options.headers[AppStrings.acceptLanguage] = lang;
    log('Lang is: $lang', name: 'AppIntercepters');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
