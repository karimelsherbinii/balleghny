import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/core/api/cache_helper.dart';
import 'package:ballaghny/core/utils/notifications_services.dart';
import 'package:ballaghny/core/utils/app_strings.dart';
import 'app.dart';
import 'bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_messaging_conig.dart' as fb;
import 'injection_container.dart' as di;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

// Define test mode constant
const bool kTestMode = bool.fromEnvironment('FLUTTER_TEST');

Future<void> resetGetIt() async {
  final getIt = GetIt.I;
  try {
    await getIt.reset();
  } catch (e) {
    debugPrint('Error during GetIt reset: $e');
  }
}

Future<void> main({bool isTest = false}) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize CacheHelper in both test and non-test modes
    await CacheHelper.init();

    // Set isFirstTime to true in test mode
    if (isTest) {
      await CacheHelper.saveData(key: AppStrings.isFirstTime, value: true);
    }

    // Initialize Firebase in both modes
    try {
      await Firebase.initializeApp();
    } catch (e) {
      debugPrint('Firebase initialization error: $e');
    }

    // Initialize dependency injection in both modes
    await di.init();

    // Skip other initialization in test mode
    if (!isTest && !kTestMode) {
      tz.initializeTimeZones();
      await NotificationsServices.initializeNotifications();
    }

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Bloc.observer = AppObserver();

    // Run the app without Phoenix in test mode to prevent restarts
    runApp(const BallaghnyApp());

    if (!isTest && !kTestMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          await fb.config();
        } catch (e) {
          debugPrint('Firebase messaging config error: $e');
        }
      });
    }
  } catch (e, stackTrace) {
    debugPrint('Error in main: $e');
    debugPrint('Stack trace: $stackTrace');
  }
}
