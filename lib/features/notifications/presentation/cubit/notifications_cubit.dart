import 'package:ballaghny/core/utils/notifications_services.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/features/notifications/data/models/notifications_data_model/notification_model.dart';
import 'package:ballaghny/features/notifications/domain/usecases/get_notifications.dart';
import 'package:ballaghny/features/notifications/domain/usecases/read_notification.dart';

import '../../domain/entity/notification_entity.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificatoins getNotificatoinsUseCase;
  final ReadNotification readNotificationUseCase;
  NotificationsCubit(this.getNotificatoinsUseCase, this.readNotificationUseCase)
      : super(NotificationsInitial());

  bool loadMore = false;
  int pageNumber = 1, totalPages = 1;
  List<NotificationModel> allNotifications = [];
  int unreadCount = 0;
  Future<void> getNotifications() async {
    if (state is GetNotificationsLoadingState) return;
    emit(GetNotificationsLoadingState(isFirstFetch: pageNumber == 1));

    Either<Failure, BaseResponse> response = await getNotificatoinsUseCase(
        GetNotificatoinsParams(pageNumber: pageNumber));
    response.fold(
        (failure) => emit(
              GetNotificationsErrorState(
                errorMessage: failure.message!,
              ),
            ), (notifications) {
      if (notifications.statusCode == 200) {
        allNotifications.addAll(notifications.data);
        totalPages = notifications.lastPage ?? 1;
        unreadCount = notifications.unReadTotal ?? 0;
        pageNumber++;
        emit(GetNotificationsLoadedState(notifications: notifications.data));
      } else {
        emit(
          GetNotificationsErrorState(
            errorMessage: notifications.message ?? 'Error',
          ),
        );
      }
    });
  }

  clearData() {
    if (allNotifications.isNotEmpty) {
      allNotifications.clear();
    }
    pageNumber = 1;
    totalPages = 1;
  }

  Future<void> readNotification({
    int? id,
   }) async {
    emit(ReadNotificationLoadingState());
    Either<Failure, BaseResponse> response =
        await readNotificationUseCase.call(ReadNotificationParams(
      id: id!,
    ));
    response.fold(
        (failure) =>
            emit(ReadNotificationErrorState(errorMessage: failure.message!)),
        (readNotification) => emit(ReadNotificationLoadedState()));
  }

  bool isNotificationEnabled = false;

  updateNotificationSwitch() {
    isNotificationEnabled = !isNotificationEnabled;
    if (isNotificationEnabled) {
      NotificationsServices.initializeNotifications();
    } else {
      NotificationsServices.cancelAllNotifications();
    }
    emit(NotificationSwitchState(isSwitched: isNotificationEnabled));
  }
}
