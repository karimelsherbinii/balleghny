import 'package:ballaghny/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:ballaghny/features/settings/data/datasources/settings_remote_datasource.dart';
import 'package:ballaghny/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:ballaghny/features/settings/domain/repositories/settings_repository.dart';
import 'package:ballaghny/features/settings/domain/usecases/change_language_usecase.dart';
import 'package:ballaghny/features/settings/domain/usecases/get_%20religions.dart';
import 'package:ballaghny/features/settings/domain/usecases/get_countries.dart';
import 'package:ballaghny/features/settings/domain/usecases/get_languages.dart';
import 'package:ballaghny/features/settings/domain/usecases/get_nationalities.dart';
import 'package:ballaghny/features/settings/domain/usecases/get_saved_language.dart';
import 'package:ballaghny/features/settings/presentation/cubit/settings_cubit.dart';

import '../../injection_container.dart';

void settingInjectionContainer() {
  // bloc
  sl.registerFactory<SettingsCubit>(() => SettingsCubit(
        changeDarkModeUseCase: sl(),
        getSavedDarkModeUseCase: sl(),
        getLanguagesUseCase: sl(),
        getNationalitiesUseCase: sl(),
        getCountriesUseCase: sl(),
        getReligionsUseCase: sl(),
      ));

  // usecases
  sl.registerLazySingleton<ChangeDarkModeUseCase>(
      () => ChangeDarkModeUseCase(darkModeRepository: sl()));
  sl.registerLazySingleton<GetSavedDarkModeUseCase>(
      () => GetSavedDarkModeUseCase(darkModeRepository: sl()));
  sl.registerLazySingleton<GetCountries>(() => GetCountries(repository: sl()));
  sl.registerLazySingleton<GetLanguages>(() => GetLanguages(repository: sl()));
  sl.registerLazySingleton<GetNationalities>(
      () => GetNationalities(repository: sl()));
  sl.registerLazySingleton<GetReligions>(() => GetReligions(repository: sl()));

  // repositories
  sl.registerLazySingleton<SettingsRepository>(() =>
      SettingsRepositoryImplementation(
          darkModeLocalDataSource: sl(), settingsRemoteDataSource: sl()));

  //local datasource
  sl.registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImplementation(sharedPreferences: sl()));
  //remote datasource
  sl.registerLazySingleton<SettingsRemoteDataSource>(
      () => SettingsRemoteDataSourceImplementation(apiConsumer: sl()));
}
