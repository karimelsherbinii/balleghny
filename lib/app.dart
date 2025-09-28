import 'dart:developer';
// import 'package:device_preview/device_preview.dart';
import 'package:ballaghny/features/auth/presentation/cubits/delete_account/delete_account_cubit.dart';
import 'package:ballaghny/features/contact_us/presentation/cubit/contact_us_cubit.dart';
import 'package:ballaghny/features/islam/presentation/cubit/islam_cubit.dart';
import 'package:ballaghny/features/islam/presentation/cubit/orders/orders_cubit.dart';
import 'package:ballaghny/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:ballaghny/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ballaghny/config/themes/app_dark_theme.dart';
import 'package:ballaghny/features/auth/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:ballaghny/features/auth/presentation/cubits/verify/verify_cubit.dart';
import 'package:ballaghny/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:ballaghny/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:ballaghny/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/locale/app_localizations_setup.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/api/cache_helper.dart';
import 'core/utils/notifications_services.dart';
import 'core/utils/app_strings.dart';
import 'features/auth/presentation/cubits/login/login_cubit.dart';
import 'features/bottom_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'features/splash/presentation/cubit/locale_cubit.dart';
import 'injection_container.dart' as di;

// Define test mode constant
const bool kTestMode = bool.fromEnvironment('FLUTTER_TEST');

class BallaghnyApp extends StatefulWidget {
  const BallaghnyApp({super.key});
  @override
  State<BallaghnyApp> createState() => _BallaghnyAppState();
}

class _BallaghnyAppState extends State<BallaghnyApp> {
  late FirebaseMessaging messaging;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late FirebaseAnalytics analytics;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void configureDidReceiveLocalNotificationSubject() {
    NotificationsServices.didReceiveLocalNotificationStream.stream.listen((
      ReceivedNotification receivedNotification,
    ) async {
      if (receivedNotification.payload != null) {
        log('receivedNotification.payload: ${receivedNotification.payload}');
        Navigator.of(
          navigatorKey.currentContext!,
        ).push(MaterialPageRoute(builder: (context) => NotificationsScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // CacheHelper.clearData();
    //firebase messaging
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((token) {
      log('firebase messaging token: $token');
    });

    // Initialize Firebase Analytics safely
    try {
      analytics = FirebaseAnalytics.instance;
    } catch (e) {
      // Handle Firebase Analytics initialization error
      analytics = FirebaseAnalytics.instance;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!kTestMode) {
        configureDidReceiveLocalNotificationSubject();
      }
    });

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Safely access CacheHelper
    try {
      log(
        CacheHelper.getData(key: AppStrings.token) ?? '',
        name: "access_token",
      );
    } catch (e) {
      // Handle CacheHelper access error
    }
    // analytics.logEvent(
    //     name: 'install',
    //     parameters: {'device': Platform.isAndroid ? 'android' : 'ios'});
  }

  @override
  void dispose() {
    NotificationsServices.didReceiveLocalNotificationStream.close();
    NotificationsServices.selectNotificationStream.close();
    // context.read<SocketCubit>().disconnect();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<LocaleCubit>()..getSavedLang()),
        BlocProvider(
          create: (_) => di.sl<LoginCubit>()..getSavedLoginCredentials(),
        ),
        BlocProvider(create: (_) => di.sl<BottomNavigationCubit>()),
        BlocProvider(
          create: (_) => di.sl<NotificationsCubit>()..getNotifications(),
        ),
        BlocProvider(create: (_) => di.sl<VerifyCubit>()),
        BlocProvider(create: (_) => di.sl<ResetPasswordCubit>()),
        BlocProvider(create: (_) => di.sl<ProfileCubit>()),
        BlocProvider(create: (_) => di.sl<SettingsCubit>()..getSavedDarkMode()),
        BlocProvider(create: (_) => di.sl<StatisticsCubit>()),
        BlocProvider(create: (_) => di.sl<IslamCubit>()),
        BlocProvider(create: (_) => di.sl<OrdersCubit>()),
        BlocProvider(create: (_) => di.sl<ContactUsCubit>()),
        BlocProvider(create: (_) => di.sl<DeleteAccountCubit>()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen:
            (previousState, currentState) => previousState != currentState,
        builder: (_, localeState) {
          return BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen:
                (previousState, currentState) => previousState != currentState,
            builder: (context, state) {
              return ScreenUtilInit(
                designSize: Size(1024, 1366), // ✅ مقاس iPad Pro

                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return MaterialApp(
                    // ignore: deprecated_member_use
                    useInheritedMediaQuery: true,
                    navigatorKey: navigatorKey,
                    title: AppStrings.appName,
                    debugShowCheckedModeBanner: false,

                    navigatorObservers: [
                      if (!kTestMode)
                        FirebaseAnalyticsObserver(analytics: analytics),
                    ],
                    onGenerateRoute: AppRoutes.onGenerateRoute,
                    // builder: DevicePreview.appBuilder,
                    theme:
                        !context.watch<SettingsCubit>().currentDarkModeState
                            ? appTheme()
                            : appDarkThemeData(context),
                    darkTheme:
                        context.watch<SettingsCubit>().currentDarkModeState
                            ? appDarkThemeData(context)
                            : appTheme(),
                    supportedLocales: AppLocalizationsSetup.supportedLocales,
                    localizationsDelegates:
                        AppLocalizationsSetup.localizationsDelegates,
                    localeResolutionCallback:
                        AppLocalizationsSetup.localeResolutionCallback,
                    locale: localeState.locale,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
