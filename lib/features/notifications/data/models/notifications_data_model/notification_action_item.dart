import 'package:ballaghny/features/notifications/domain/entity/notification_action_entity.dart';

class NotificationActionItem extends NotificationActionEntity {
  const NotificationActionItem({
    super.mode,
    super.itemId,
  });

  factory NotificationActionItem.fromJson(Map<String, dynamic> json) =>
      NotificationActionItem(
        mode: json['mode'] as String?,
        itemId: json['item_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'mode': mode,
        'item_id': itemId,
      };
}
