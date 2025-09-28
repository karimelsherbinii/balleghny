import 'package:equatable/equatable.dart';
import 'package:ballaghny/features/notifications/domain/entity/notification_action_entity.dart';

class NotificationEntity extends Equatable {
  final int? id;
  final String? title;
  final String? message;
  final String? body;
  final String? link;
  final dynamic priority;
  final dynamic iconClass;
  final int isRead;
  final dynamic soundUrl;
  final NotificationActionEntity? notificationActionEntity;
  final String? mode;
  final int? itemId;
  final String? createdAtDate;
  final String? createdAtTime;
  const NotificationEntity({
    this.id,
    this.title,
    this.message,
    this.body,
    this.link,
    this.priority,
    this.iconClass,
    required this.isRead,
    this.soundUrl,
    this.notificationActionEntity,
    this.mode,
    this.itemId,
    this.createdAtDate,
    this.createdAtTime,
  });
  @override
  List<Object?> get props => [
        id,
        title,
        message,
        body,
        link,
        priority,
        iconClass,
        isRead,
        soundUrl,
        notificationActionEntity,
        mode,
        itemId,
        createdAtDate,
        createdAtTime,
      ];
}
