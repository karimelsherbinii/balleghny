import 'package:equatable/equatable.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/notifications/domain/repository/notifications_repository.dart';
import '../../../../core/api/base_response.dart';

class GetNotificatoins
    implements UseCase<BaseResponse, GetNotificatoinsParams> {
  final NotificationsRepository notificationsRepository;
  GetNotificatoins({required this.notificationsRepository});

  @override
  Future<Either<Failure, BaseResponse>> call(params) {
    return notificationsRepository.getNotifications(
        pageNumber: params.pageNumber);
  }
}

class GetNotificatoinsParams extends Equatable {
  final int pageNumber;

  const GetNotificatoinsParams({required this.pageNumber});

  @override
  List<Object?> get props => [pageNumber];
}
