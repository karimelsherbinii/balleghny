import 'package:ballaghny/features/about_app/domain/usecases/get_about_app_content.dart';
import 'package:ballaghny/features/about_app/data/datasources/about_app_remote_data_source.dart';
import 'package:ballaghny/features/about_app/domain/repositories/about_app_repository.dart';
import 'package:ballaghny/features/about_app/presentation/cubit/about_app_cubit.dart';

import '../../injection_container.dart';
import 'data/repositories/about_app_repository_impl.dart';

void initAboutAppFeature() {
// Blocs
  sl.registerFactory<AboutAppCubit>(
      () => AboutAppCubit(getAboutAppContent: sl()));

  // Use cases
  sl.registerLazySingleton<GetAboutAppContent>(
      () => GetAboutAppContent(aboutAppRepository: sl()));

  // Repository
  sl.registerLazySingleton<AboutAppRepository>(
      () => AboutAppRepositoryImpl(aboutAppRemoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<AboutAppRemoteDataSource>(
      () => AboutAppRemoteDataSourceImpl(apiConsumer: sl()));
}
