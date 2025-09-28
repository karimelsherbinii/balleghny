import 'package:ballaghny/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:ballaghny/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:ballaghny/features/profile/domain/repositories/profile_repository.dart';
import 'package:ballaghny/features/profile/domain/usecases/get_profile.dart';
import 'package:ballaghny/features/profile/domain/usecases/update_profile.dart';
import 'package:ballaghny/features/profile/domain/usecases/upload_image.dart';
import 'package:ballaghny/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:ballaghny/injection_container.dart';

Future<void> profileInjectionContainer() async {
  //************ [Cubits] *************
  //
  sl.registerFactory<ProfileCubit>(() => ProfileCubit(sl(), sl(), sl()));

  //************ [USECASES] *************
  //

  sl.registerLazySingleton<GetProfileData>(() => GetProfileData(sl()));
  sl.registerLazySingleton<UpdateProfileData>(() => UpdateProfileData(sl()));
  sl.registerLazySingleton<UploadImage>(() => UploadImage(sl()));

  //************ [REPOSITORIES] *************
  //
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(profileRemoteDataSource: sl()));
  //************ [REMOTE DATA SOURCE] *************
  //
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(sl()));
}
