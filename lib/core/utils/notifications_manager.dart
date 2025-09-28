
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ballaghny/core/utils/notifications_services.dart';

import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

abstract class NotificarionsManager {
  static void showNotification({
    String? title,
    String? body,
    String? payload,
  }) async {
    var android = const AndroidNotificationDetails(
        'one time notification id', 'channel',
        channelDescription: 'your channel description',
        priority: Priority.high,
        importance: Importance.max);
    var platform = NotificationDetails(
        android: android, iOS: NotificationsServices.iosNotificationDetails);
    await NotificationsServices.flutterLocalNotificationsPlugin.show(
      id++,
      title ?? '',
      body ?? '',
      platform,
      payload: payload ?? '',
    );
  }

  // static void configureDidReceiveLocalNotificationSubject(
  //   BuildContext context,
  // ) {
  //   NotificationsServices.didReceiveLocalNotificationStream.stream
  //       .listen((ReceivedNotification receivedNotification) async {
  //     if (receivedNotification.payload != null) {
  //       log('receivedNotification.payload: ${receivedNotification.payload}');
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute<void>(
  //             builder: (BuildContext context) => NotificationsScreen()),
  //       );
  //     }
  //   });
  // }

  //show notification with sound at a specific time
  static void showNotificationAtTime({
    required int id,
    required String title,
    required String body,
    required String payload,
    required DateTime scheduledDate,
    bool withAzan = true,
  }) async {
    if (scheduledDate.isBefore(DateTime.now())) {
      // Adjust to a few seconds in the future if it’s in the past
      scheduledDate = DateTime.now().add(Duration(seconds: 5));
      print('Adjusted scheduledDate to: $scheduledDate');
    }

    var android = AndroidNotificationDetails(
        'repeating channel id', 'repeating channel name',
        channelDescription: 'repeating description',
        importance: Importance.max,
        priority: Priority.high,
        // sound: withAzan ? RawResourceAndroidNotificationSound('azan') : null,
        );

    var iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      // sound:
      // withAzan ? 'azan.wav' : null,
    );

    var platform = NotificationDetails(
      android: android,
      iOS: iosDetails,
    );

    await NotificationsServices.flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platform,
      // androidAllowWhileIdle: true,
      // uiLocalNotificationDateInterpretation:
      //     UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  //show azan repeated at spesefic time
  static void showAzanRepeatedlyAtTime({
    required int id,
    required String title,
    required String body,
    required String payload,
    required DateTime scheduledDate,
  }) async {
    var android = const AndroidNotificationDetails(
        'repeating channel id', 'repeating channel name',
        channelDescription: 'repeating description',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('azan'));
    var platform = NotificationDetails(
      android: android,
      iOS: NotificationsServices.iosNotificationDetails,
    );
    await NotificationsServices.flutterLocalNotificationsPlugin.zonedSchedule(
      id++,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platform,
      // androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      // uiLocalNotificationDateInterpretation:
      //     UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
