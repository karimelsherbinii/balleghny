import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:ballaghny/features/splash/presentation/cubit/locale_cubit.dart';

import '../../config/routes/app_routes.dart';

class NotificationLableAlert extends StatefulWidget {
  final Color? notificationColor;
  const NotificationLableAlert({super.key, this.notificationColor});

  @override
  State<NotificationLableAlert> createState() => _NotificationLableAlertState();
}

class _NotificationLableAlertState extends State<NotificationLableAlert> {
  @override
  void initState() {
    context.read<NotificationsCubit>().getNotifications();
    log(context.read<NotificationsCubit>().unreadCount.toString(),
        name: 'unreadCount');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        return SizedBox(
          width: 70,
          height: 40,
          child: Stack(
            children: [
              context.read<LocaleCubit>().currentLangCode == "ar"
                  ? Positioned(
                      left: 0,
                      bottom: context.height * 0.01,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.notificationsRoute);
                        },
                        child: Icon(
                          Icons.notifications,
                          color: widget.notificationColor ?? Colors.white,
                        ),
                      ),
                    )
                  : Positioned(
                      right: 0,
                      bottom: context.height * 0.01,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.notificationsRoute);
                        },
                        child: Icon(
                          Icons.notifications,
                          color: widget.notificationColor ?? Colors.white,
                        ),
                      ),
                    ),
              if (context.read<NotificationsCubit>().unreadCount >= 1 ||
                  state is! GetNotificationsLoadingState)
                context.read<LocaleCubit>().currentLangCode == "ar"
                    ? Positioned(
                        left: context.height * 0.012,
                        top: 0,
                        child: context.read<NotificationsCubit>().unreadCount !=
                                0
                            ? Container(
                                height: context
                                            .read<NotificationsCubit>()
                                            .unreadCount >
                                        10
                                    ? 20
                                    : 17,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                  child: FittedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        context
                                            .read<NotificationsCubit>()
                                            .unreadCount
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: context.width * 0.03,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      )
                    : Positioned(
                        right: context.height * 0.012,
                        top: 0,
                        child: context.read<NotificationsCubit>().unreadCount !=
                                0
                            ? Container(
                                height: context
                                            .read<NotificationsCubit>()
                                            .unreadCount >
                                        10
                                    ? 20
                                    : 17,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                  child: FittedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        context
                                            .read<NotificationsCubit>()
                                            .unreadCount
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: context.width * 0.03,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      )
              else
                Container()
            ],
          ),
        );
      },
    );
  }
}
