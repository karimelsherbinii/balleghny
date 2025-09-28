import 'package:dartz/dartz.dart';

import '../../../../core/api/base_response.dart';
import '../../../../core/error/failures.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, BaseResponse>> getNotifications(
      {required int pageNumber});
  Future<Either<Failure, BaseResponse>> readNotification({
    int? id,
  });
}
