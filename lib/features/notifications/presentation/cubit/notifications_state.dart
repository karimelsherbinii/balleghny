part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class GetNotificationsLoadingState extends NotificationsState {
  final bool isFirstFetch;
  const GetNotificationsLoadingState({required this.isFirstFetch});
  @override
  List<Object> get props => [isFirstFetch];
}

class GetNotificationsLoadedState extends NotificationsState {
  final List<NotificationEntity> notifications;
  const GetNotificationsLoadedState({required this.notifications});
  @override
  List<Object> get props => [notifications];
}

class GetNotificationsErrorState extends NotificationsState {
  final String errorMessage;
  const GetNotificationsErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

// post
class ReadNotificationLoadingState extends NotificationsState {
  @override
  List<Object> get props => [];
}

class ReadNotificationLoadedState extends NotificationsState {
  @override
  List<Object> get props => [];
}

class ReadNotificationErrorState extends NotificationsState {
  final String errorMessage;
  const ReadNotificationErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class NotificationSwitchState extends NotificationsState {
  final bool isSwitched;
  const NotificationSwitchState({required this.isSwitched});
  @override
  List<Object> get props => [isSwitched];
}
