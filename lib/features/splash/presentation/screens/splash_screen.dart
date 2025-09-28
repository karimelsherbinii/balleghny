import 'dart:async';
import 'dart:developer';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/app_strings.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/features/home/presentation/screens/home_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/animation/slide_in.dart';
import '../../../../core/api/cache_helper.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/screen_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  bool isFirstTime = CacheHelper.getData(key: AppStrings.isFirstTime) ?? true;
  // String? selectedLang = CacheHelper.getData(key: AppStrings.selectedLang)!;

  _goNext() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString(AppStrings.token) != null) {
      Navigator.pushReplacementNamed(
        context,
        Routes.homeScreen,
        arguments: {'widget': HomeBodyScreen()},
      );
    } else {
      if (isFirstTime == true) {
        Navigator.pushReplacementNamed(context, Routes.onboardingScreen);
        await CacheHelper.saveData(key: AppStrings.isFirstTime, value: false);
      } else {
        log('isFirstTime: $isFirstTime');
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      }
    }
  }

  _startDelay() => _timer = Timer(const Duration(seconds: 3), () => _goNext());

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildBodyContent() {
    return Container(
      decoration: const BoxDecoration(
        // Background Image
        image: DecorationImage(
          image: AssetImage(AppAssets.splashBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // app logo
          Center(
            child: SlideIn(
              msDelay: 1300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.logo, width: context.width * 0.33),
                  Text(
                    AppLocalizations.of(context)!.translate('app_name')!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      key: const Key('splash_screen'),
      child: Scaffold(body: _buildBodyContent()),
    );
  }
}
