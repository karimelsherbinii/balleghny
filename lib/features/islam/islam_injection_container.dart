import 'package:ballaghny/features/islam/data/datasources/islam_remote_datasource.dart';
import 'package:ballaghny/features/islam/data/repositories/islam_repository_impl.dart';
import 'package:ballaghny/features/islam/domain/repositories/islam_repository.dart';
import 'package:ballaghny/features/islam/domain/usecases/get_introductions.dart';
import 'package:ballaghny/features/islam/domain/usecases/get_orders.dart';
import 'package:ballaghny/features/islam/domain/usecases/invite_to_islam.dart';
import 'package:ballaghny/features/islam/domain/usecases/share_definition.dart';
import 'package:ballaghny/features/islam/presentation/cubit/islam_cubit.dart';
import 'package:ballaghny/features/islam/presentation/cubit/orders/orders_cubit.dart';

import '../../injection_container.dart';

void islamInjectionContainer() {
  // bloc
  sl.registerFactory<IslamCubit>(() => IslamCubit(sl(), sl(), sl()));
  sl.registerFactory<OrdersCubit>(() => OrdersCubit(sl()));
  // usecases
  sl.registerLazySingleton<GetIntroductions>(() => GetIntroductions(sl()));
  sl.registerLazySingleton<InviteToIslam>(() => InviteToIslam(sl()));
  sl.registerLazySingleton<GetOrders>(() => GetOrders(sl()));
  sl.registerLazySingleton<ShareDefinition>(() => ShareDefinition(sl()));

  // repositories
  sl.registerLazySingleton<IslamRepository>(
      () => IslamRepositoryImpl(remoteDataSource: sl()));

  //  datasource
  sl.registerLazySingleton<IslamRemoteDataSource>(
      () => IslamRemoteDataSourceImpl(apiConsumer: sl()));
}
