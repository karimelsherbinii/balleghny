import 'package:ballaghny/features/onboarding/presentation/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/core/utils/app_strings.dart';
import 'package:ballaghny/features/about_app/presentation/cubit/about_app_cubit.dart';
import 'package:ballaghny/features/about_app/presentation/screens/about_app_screen.dart';
import 'package:ballaghny/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:ballaghny/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:ballaghny/features/auth/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:ballaghny/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:ballaghny/features/auth/presentation/screens/login_screen.dart';
import 'package:ballaghny/features/auth/presentation/screens/register_screen.dart';
import 'package:ballaghny/features/auth/presentation/screens/reset_new_password_screen.dart';
import 'package:ballaghny/features/auth/presentation/screens/verify_email_code_screen.dart';
import 'package:ballaghny/features/auth/presentation/screens/verify_password_code_screen.dart';
import 'package:ballaghny/features/home/presentation/screens/home_body.dart';
import 'package:ballaghny/features/home/presentation/screens/home_screen.dart';
import 'package:ballaghny/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:ballaghny/features/splash/presentation/screens/splash_screen.dart';
import 'package:ballaghny/features/terms_and_conditions/presentation/cubit/terms_and_conditions_cubit.dart';
import 'package:ballaghny/features/terms_and_conditions/presentation/screens/terms_and_conditions_screen.dart';

import '../../injection_container.dart' as di;

class Routes {
  static const String initialRoute = '/';
  static const String homeScreen = '/homeScreen';
  static const String unloginMainRoute = '/unloginMainRoute';
  static const String registerRoute = '/registerRoute';
  static const String loginRoute = '/loginRoute';
  static const String forgotPasswordRoute = '/forgotPasswordRoute';
  static const String resetNewPasswordRoute = '/resetNewPasswordRoute';
  static const String setPasswordRoute = '/setPasswordRoute';
  static const String aboutAppRoute = '/aboutAppRoute';
  static const String termsAndConditionsRoute = '/termsAndConditionsRoute';
  static const String notificationsRoute = '/notificationsRoute';
  static const String onboardingScreen = '/onboardingScreen';
  static const String languagesScreen = '/languagesScreen';
  static const String tourismSearchScreen = '/tourismSearchScreen';
  static const String itemsScreen = '/itemsScreen';
  static const String mainRoute = '/mainRoute';
  static const String tourismDetailsScreen = '/tourismDetailsScreen';
  static const String knowalageHubDetailsScreen = '/knowalageHubDetailsScreen';
  static const String virtualTourDetailsScreen = '/virtualTourDetailsScreen';
  static const String autoDetectLocationScreen = '/autoDetectLocationScreen';
  static const String manualDetectLocationScreen =
      '/manualDetectLocationScreen';
  static const String travelerSearchScreen = '/travelerSearchScreen';
  static const String salatyScreen = '/salatyScreen';
  static const String editLocationScreen = '/editLocationScreen';
  static const String verifyEmailCode = '/verifyEmailCode';
  static const String verifyPasswordCode = '/verifyPasswordCode';
  static const String libraryItemsScreen = '/libraryItemsScreen';
  static const String libraryItemDetailsScreen = '/libraryItemDetailsScreen';
  static const String searchScreen = '/searchScreen';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
            builder: (_) => SplashScreen(
                // code: '2233',
                // mobile: '01151375290',
                ));

      case Routes.mainRoute:
        return MaterialPageRoute(
            builder: (_) => BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      return HomeScreen(
                        mainBody: HomeBodyScreen(),
                      );
                    } else {
                      return LoginScreen();
                    }
                  },
                ));

      case Routes.homeScreen:
        final data = args as Map<String, dynamic>;
        final widget = data['widget'];
        return MaterialPageRoute(builder: (_) => HomeScreen(mainBody: widget));

      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.registerRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => di.sl<RegisterCubit>(),
                child: const RegisterScreen()));

      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => di.sl<ResetPasswordCubit>(),
                child: const ForgotPasswordScreen()));

      case Routes.resetNewPasswordRoute:
        return MaterialPageRoute(
            builder: (_) => const ResetNewPasswordScreen());

      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());

      case Routes.aboutAppRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => di.sl<AboutAppCubit>(),
                child: const AboutAppScreen()));

      case Routes.termsAndConditionsRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => di.sl<TermsAndConditionsCubit>(),
                child: const TermsAndConditionsScreen()));

      case Routes.notificationsRoute:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      case Routes.verifyEmailCode:
        var data = args as Map<String, dynamic>;
        var email = data['email'];
        var type = data['type'];
        return MaterialPageRoute(
            builder: (_) => VerifyEmailCodeScreen(
                  email: email,
                  type: type,
                ));
      case Routes.verifyPasswordCode:
        var data = args as Map<String, dynamic>;
        var mobile = data['mobile'];
        return MaterialPageRoute(
            builder: (_) => VerifyPasswordCodeScreen(
                  mobile: mobile,
                ));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
