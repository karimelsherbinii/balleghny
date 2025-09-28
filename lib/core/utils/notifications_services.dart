import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

int id = 0;

abstract class NotificationsServices {
  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  static final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  static final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    // onDidReceiveLocalNotification:
    //     (int id, String? title, String? body, String? payload) async {
    //   didReceiveLocalNotificationStream.add(
    //     ReceivedNotification(
    //       id: id,
    //       title: title,
    //       body: body,
    //       payload: payload,
    //     ),
    //   );
    // },
    notificationCategories: darwinNotificationCategories,
  );

  static final InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final StreamController<ReceivedNotification>
      didReceiveLocalNotificationStream =
      StreamController<ReceivedNotification>.broadcast();

  static final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  static const MethodChannel platform =
      MethodChannel('dexterx.dev/flutter_local_notifications_example');

  static const String portName = 'notification_send_port';

  static const DarwinNotificationDetails iosNotificationDetails =
      DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryPlain,
  );

  String? selectedNotificationPayload;

  Future<NotificationAppLaunchDetails?>
      getNotificationAppLaunchDetails() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await NotificationsServices.flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();
    return notificationAppLaunchDetails;
  }

  static const String urlLaunchActionId = 'id_1';
  static const String navigationActionId = 'id_3';
  static const String darwinNotificationCategoryText = 'textCategory';
  static const String darwinNotificationCategoryPlain = 'plainCategory';

  static AndroidNotificationChannel androidChannel =
      const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
  );

  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    debugPrint('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      debugPrint(
          'notification action tapped with input: ${notificationResponse.input}');
    }
  }

  static cancelAllNotifications() async {
    await NotificationsServices.flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Start foreground service
  static Future<void> startForegroundService() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    await NotificationsServices.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.startForegroundService(1, 'plain title', 'plain body',
            notificationDetails: androidNotificationDetails, payload: 'item x');
  }

  /// Start foreground service with blue background
  static Future<void>
      startForegroundServiceWithBlueBackgroundNotification() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      androidChannel.id,
      androidChannel.name,
      channelDescription: 'color background channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      color: Colors.blue,
      colorized: true,
      sound: const RawResourceAndroidNotificationSound('slow_spring_board'),
    );
  }

  /// Setup all notification channels , services  and permissions
  static Future<void> initializeNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    // بدء الخدمة الأمامية
    await startForegroundService();
    await startForegroundServiceWithBlueBackgroundNotification();

    bool notificationsEnabled = false;

    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null && androidVersion() >= 33) {
        // فقط طلب إذن التنبيهات إذا كان الإصدار Android 13 أو أعلى
        final bool? granted =
            await androidImplementation.requestNotificationsPermission();
        notificationsEnabled = granted ?? false;
      } else {
        notificationsEnabled =
            true; // افتراض أن التنبيهات مسموح بها للإصدارات الأقل من Android 13
      }
    }

    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
    }

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        didReceiveLocalNotificationStream.add(
          ReceivedNotification(
            payload: notificationResponse.payload,
            id: 0,
            title: '',
            body: '',
          ),
        );
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

int androidVersion() {
  if (Platform.isAndroid) {
    String osVersion = Platform.operatingSystemVersion;
    RegExp regex = RegExp(r'\d+'); // للتأكد من وجود رقم الإصدار
    Match? match = regex.firstMatch(osVersion);
    if (match != null) {
      return int.parse(match.group(0)!); // إرجاع الرقم كـ int
    }
  }
  return 0; // في حال فشل التحليل
}
