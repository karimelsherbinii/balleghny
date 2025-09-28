import 'package:ballaghny/features/notifications/data/datasource/notificatoins_remote_datasource.dart';
import 'package:ballaghny/features/notifications/data/repository/notifications_repository_implmentation.dart';
import 'package:ballaghny/features/notifications/domain/repository/notifications_repository.dart';
import 'package:ballaghny/features/notifications/domain/usecases/get_notifications.dart';
import 'package:ballaghny/features/notifications/domain/usecases/read_notification.dart';
import 'package:ballaghny/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:ballaghny/injection_container.dart';

Future<void> notificationsInjectionContainer() async {
  //************ [Cubits] *************
  //
  sl.registerFactory<NotificationsCubit>(() => NotificationsCubit(sl(), sl()));
  // sl.registerFactory<SocketCubit>(() => SocketCubit(sl(), sl()));

  //************ [USECASES] *************
  //
  sl.registerLazySingleton<GetNotificatoins>(
      () => GetNotificatoins(notificationsRepository: sl()));
  sl.registerLazySingleton<ReadNotification>(
      () => ReadNotification(notificationsRepository: sl()));
  // sl.registerLazySingleton<SignallingService>(() => SignallingService());
  //
  //************ [REPOSITORIES] *************
  //
  sl.registerLazySingleton<NotificationsRepository>(() =>
      NotificationsRepositoryImplementation(notificationsDataSource: sl()));
  //************ [REMOTE DATA SOURCE] *************
  //
  sl.registerLazySingleton<NotificationsRemoteDataSource>(
      () => NotificationsRemoteDataSourceImplementation(apiConsumer: sl()));
}
