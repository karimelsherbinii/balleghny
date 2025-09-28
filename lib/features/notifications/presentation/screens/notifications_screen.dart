import 'dart:async';

import 'package:ballaghny/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/core/widgets/default_back_button.dart';
import 'package:ballaghny/core/widgets/no_data.dart';
import 'package:ballaghny/features/auth/data/models/user_model.dart';
import 'package:ballaghny/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:ballaghny/features/notifications/presentation/cubit/notifications_cubit.dart';
import '../../../../../core/widgets/error_widget.dart' as DefaultErrorWidget;
import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../data/models/notifications_data_model/notification_model.dart';
import '../widgets/notifications_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with TickerProviderStateMixin {
  _getAllNotifications() =>
      BlocProvider.of<NotificationsCubit>(context).getNotifications();

  // scrolling
  var _scrollController = ScrollController();
  AnimationController? _animationController;
  void _setupScrollController(context) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0 &&
            BlocProvider.of<NotificationsCubit>(context).pageNumber <=
                BlocProvider.of<NotificationsCubit>(context).totalPages) {
          _getAllNotifications();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 1000),
    );
    _scrollController = ScrollController();

    BlocProvider.of<NotificationsCubit>(context).clearData();
    _getAllNotifications();
    _setupScrollController(context);
  }

  @override
  void dispose() {
    _animationController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultBackButton(),
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      title: Text(
        AppLocalizations.of(context)!.translate(AppStrings.notifications) ?? '',
        style: TextStyle(color: Colors.black),
      ),
    );
    return Scaffold(appBar: appBar, body: buildAllNotificationsWidget());
  }

  Widget buildAllNotificationsWidget() {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        if (state is GetNotificationsLoadingState && state.isFirstFetch ||
            state is ReadNotificationLoadingState) {
          return const Center(child: LoadingIndicator());
        }
        if (state is ReadNotificationLoadedState) {
          BlocProvider.of<NotificationsCubit>(context).clearData();
          BlocProvider.of<NotificationsCubit>(context).getNotifications();
        }
        if (state is GetNotificationsLoadingState ||
            state is ReadNotificationLoadingState) {
          BlocProvider.of<NotificationsCubit>(context).loadMore = true;
        } else if (state is GetNotificationsErrorState) {
          return DefaultErrorWidget.DefaultErrorWidget(
            msg: state.errorMessage,
            onRetryPressed: () {
              _getAllNotifications();
            },
          );
        }

        var cubit = context.read<NotificationsCubit>();

        if (BlocProvider.of<NotificationsCubit>(
              context,
            ).allNotifications.isNotEmpty ||
            state is ReadNotificationLoadedState) {
          //add to notifications list dumy notification model

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              controller: _scrollController,
              itemCount:
                  cubit.allNotifications.length +
                  (BlocProvider.of<NotificationsCubit>(context).loadMore
                      ? 1
                      : 0),
              separatorBuilder:
                  ((context, index) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(),
                  )),
              itemBuilder: (context, index) {
                final count =
                    BlocProvider.of<NotificationsCubit>(
                              context,
                            ).allNotifications.length >
                            10
                        ? 10
                        : BlocProvider.of<NotificationsCubit>(
                          context,
                        ).allNotifications.length;
                final Animation<double> animation = Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController!,
                    curve: Interval(
                      (1 / count) * index,
                      1.0,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                );
                _animationController?.forward();
                if (index <=
                    BlocProvider.of<NotificationsCubit>(
                          context,
                        ).allNotifications.length -
                        1) {
                  return NotificationItem(
                    animation: animation,
                    animationController: _animationController,
                    notification:
                        BlocProvider.of<NotificationsCubit>(
                          context,
                        ).allNotifications[index],
                    onTap: () {
                      // notificatoinsConditions(context, cubit, index);
                      //read notification
                      BlocProvider.of<NotificationsCubit>(
                        context,
                      ).readNotification(
                        id:
                            BlocProvider.of<NotificationsCubit>(
                              context,
                            ).allNotifications[index].id!,
                      );
                      if (cubit.allNotifications[index].link != null) {
                        Constants.openUrl(
                          cubit.allNotifications[index].link ?? '',
                        );
                      }
                    },
                  );
                } else if (BlocProvider.of<NotificationsCubit>(
                      context,
                    ).pageNumber <=
                    cubit.totalPages) {
                  Timer(const Duration(milliseconds: 30), () {
                    _scrollController.jumpTo(
                      _scrollController.position.maxScrollExtent,
                    );
                  });

                  return const Center(child: LoadingIndicator());
                }
                return const SizedBox();
              },
            ),
          );
        } else if (state is ReadNotificationLoadingState) {
          return const Center(child: LoadingIndicator());
        } else {
          return Center(
            child: NoData(
              message:
                  AppLocalizations.of(
                    context,
                  )!.translate('no_notifications_found') ??
                  '',
            ),
          );
        }
      },
    );
  }
}
