import 'package:ballaghny/features/statistics/data/datasources/statistics_remote_datasource.dart';
import 'package:ballaghny/features/statistics/data/repositories/statistics_repository_impl.dart';
import 'package:ballaghny/features/statistics/domain/repositories/statistics_repository.dart';
import 'package:ballaghny/features/statistics/domain/usecases/get_chart_statistics.dart';
import 'package:ballaghny/features/statistics/domain/usecases/get_statistics.dart';
import 'package:ballaghny/features/statistics/presentation/cubit/statistics_cubit.dart';

import '../../injection_container.dart';

void statisticsInjectionContainer() {
  // bloc
  sl.registerFactory<StatisticsCubit>(() => StatisticsCubit(
        sl(),
        sl(),
      ));

  // usecases
  sl.registerFactory<GetStatistics>(() => GetStatistics(sl()));
  sl.registerFactory<GetChartStatistics>(() => GetChartStatistics(sl()));

  // repositories
  sl.registerFactory<StatisticsRepository>(
      () => StatisticsRepositoryImpl(remoteDataSource: sl()));

  //  datasource
  sl.registerFactory<StatisticsRemoteDatasource>(
      () => StatisticsRemoteDatasourceImpl(apiConsumer: sl()));
}
