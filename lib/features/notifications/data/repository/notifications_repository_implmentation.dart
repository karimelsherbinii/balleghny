import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/exceptions.dart';
import 'package:ballaghny/features/notifications/data/datasource/notificatoins_remote_datasource.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ballaghny/features/notifications/domain/repository/notifications_repository.dart';

class NotificationsRepositoryImplementation implements NotificationsRepository {
  final NotificationsRemoteDataSource notificationsDataSource;
  NotificationsRepositoryImplementation(
      {required this.notificationsDataSource});
  @override
  Future<Either<Failure, BaseResponse>> getNotifications(
      {required int pageNumber}) async {
    try {
      final getRemoteNotifications = await notificationsDataSource
          .getNotifications(pageNumber: pageNumber);
      return Right(getRemoteNotifications);
    } on ServerException catch (exeption) {
      return Left(ServerFailure(message: exeption.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> readNotification({
    int? id,
  }) async {
    try {
      final response = await notificationsDataSource.readNotificatoin(
        id: id!,
      );
      return Right(response);
    } on ServerException catch (exeption) {
      return Left(ServerFailure(message: exeption.message));
    }
  }
}
