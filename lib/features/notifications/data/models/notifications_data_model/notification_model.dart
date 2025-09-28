import 'package:ballaghny/features/notifications/domain/entity/notification_entity.dart';
import 'notification_action_item.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    super.id,
    super.title,
    super.message,
    super.body,
    super.link,
    super.priority,
    super.iconClass,
    required super.isRead,
    super.soundUrl,
    super.notificationActionEntity,
    super.mode,
    super.itemId,
    super.createdAtDate,
    super.createdAtTime,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        message: json['message'] as String?,
        body: json['body'] as String?,
        link: json['link'] as String?,
        priority: json['priority'] as dynamic,
        iconClass: json['icon_class'] as dynamic,
        isRead: json['read'] as int,
        soundUrl: json['sound_url'] as dynamic,
        notificationActionEntity: json['data_array'] == null
            ? null
            : NotificationActionItem.fromJson(
                json['data_array'] as Map<String, dynamic>),
        mode: json['mode'] as String?,
        itemId: json['item_id'] as int?,
        createdAtDate: json['created_at'] as String?,
        createdAtTime: json['created_at_time'] as String?,
      );
}
