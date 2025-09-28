import 'package:ballaghny/features/contact_us/contact_us_injection_container.dart';
import 'package:ballaghny/features/islam/islam_injection_container.dart';
import 'package:ballaghny/features/statistics/statistics_injection_container.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ballaghny/features/about_app/about_app_injection_container.dart';
import 'package:ballaghny/features/auth/auth_injection_container.dart';
import 'package:ballaghny/features/bottom_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:ballaghny/features/notifications/notifications_injection_container.dart';
import 'package:ballaghny/features/profile/profile_injection_container.dart';
import 'package:ballaghny/features/settings/settings_injection_container.dart';
import 'package:ballaghny/features/terms_and_conditions/terms_and_conditions_injection_container.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// import 'package:utrujja/features/library/library_injection_container.dart';
import 'core/network/network_info.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'features/splash/data/datasources/lang_local_data_source.dart';
import 'features/splash/data/repositories/lang_repository_impl.dart';
import 'features/splash/domain/repositories/lang_repository.dart';
import 'features/splash/domain/usecases/change_lang.dart';
import 'features/splash/domain/usecases/get_saved_lang.dart';
import 'features/splash/presentation/cubit/locale_cubit.dart';

GetIt sl = GetIt.instance;
Future<void> init() async {
  // Blocs
  sl.registerFactory<LocaleCubit>(
    () => LocaleCubit(changeLangUseCase: sl(), getSavedLangUseCase: sl()),
  );
  sl.registerFactory<BottomNavigationCubit>(() => BottomNavigationCubit());

  // Use cases
  sl.registerLazySingleton<GetSavedLang>(
    () => GetSavedLang(langRepository: sl()),
  );
  sl.registerLazySingleton<ChangeLang>(() => ChangeLang(langRepository: sl()));

  // Repository
  sl.registerLazySingleton<LangRepository>(
    () => LangRepositoryImpl(langLocalDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<LangLocalDataSource>(
    () => LangLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features

  initAboutAppFeature();
  initTermsAndConditionsFeature();
  initAuthFeature();
  notificationsInjectionContainer();
  profileInjectionContainer();
  settingInjectionContainer();
  statisticsInjectionContainer();
  islamInjectionContainer();
  contactUsInjectionContainer();

  //core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );
  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
  sl.registerLazySingleton(
    () => LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      requestBody: true,
    ),
  );
  sl.registerLazySingleton(() => AppIntercepters(langLocalDataSource: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
