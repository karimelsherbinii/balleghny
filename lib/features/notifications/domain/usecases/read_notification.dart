import 'package:equatable/equatable.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/notifications/domain/repository/notifications_repository.dart';

class ReadNotification
    implements UseCase<BaseResponse, ReadNotificationParams> {
  final NotificationsRepository notificationsRepository;
  ReadNotification({required this.notificationsRepository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      ReadNotificationParams postParams) {
    return notificationsRepository.readNotification(id: postParams.id);
  }
}

class ReadNotificationParams extends Equatable {
  final int id;
  const ReadNotificationParams({
    required this.id,
  });
  @override
  List<Object?> get props => [
        id,
      ];
}
