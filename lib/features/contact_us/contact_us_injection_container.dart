import 'package:ballaghny/features/contact_us/data/datasources/contact_us_remote_datasource.dart';
import 'package:ballaghny/features/contact_us/data/repositories/contact_us_repository_impl.dart';
import 'package:ballaghny/features/contact_us/domain/repositories/contact_us_repository.dart';
import 'package:ballaghny/features/contact_us/domain/usecases/contact_us_profile.dart';
import 'package:ballaghny/features/contact_us/presentation/cubit/contact_us_cubit.dart';
import 'package:ballaghny/injection_container.dart';

Future<void> contactUsInjectionContainer() async {
  //************ [Cubits] *************
  //
  sl.registerFactory<ContactUsCubit>(
      () => ContactUsCubit(contactUsUseCase: sl()));

  //************ [USECASES] *************
  //

  sl.registerLazySingleton<ContactUs>(() => ContactUs(sl()));

  //************ [REPOSITORIES] *************
  //
  sl.registerLazySingleton<ContactUsRepository>(
      () => ContactUsRepositoryImpl(profileRemoteDataSource: sl()));
  //************ [REMOTE DATA SOURCE] *************
  //
  sl.registerLazySingleton<ContactUsRemoteDataSource>(
      () => ContactUsRemoteDataSourceImpl(sl()));
}
