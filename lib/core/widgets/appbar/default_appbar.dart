import 'package:ballaghny/config/routes/app_routes.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/features/bottom_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:ballaghny/features/home/presentation/screens/home_body.dart';
import 'package:ballaghny/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;
  final Widget? actionIcon;
  final Function()? onActionTap;
  final bool showBackButton;
  final Function()? onBackTap;

  const DefaultAppBar({
    super.key,
    required this.title,
    this.actionIcon,
    this.onActionTap,
    this.showBackButton = true,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        if (showBackButton)
          InkWell(
              onTap: onBackTap != null
                  ? onBackTap!
                  : () {
                      Navigator.pushNamed(context, Routes.homeScreen,
                          arguments: {
                            'widget': HomeBodyScreen(),
                          });
                      context
                          .read<BottomNavigationCubit>()
                          .upadateBottomNavIndex(0);
                    },
              child: Icon(Icons.arrow_back)),
        if (!showBackButton) SizedBox(width: 24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            return InkWell(
              onTap: onActionTap ??
                  () {
                    Navigator.pushNamed(context, Routes.notificationsRoute);
                  },
              child: actionIcon ??
                  Image.asset(context
                          .read<NotificationsCubit>()
                          .allNotifications
                          .isNotEmpty
                      ? AppAssets.notificationFillIcon
                      : AppAssets.notificationIcon), //or notificationFillIcon
            );
          },
        )
      ]),
    );
  }
}
