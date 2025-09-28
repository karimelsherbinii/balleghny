import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/default_list_tile.dart';
import '../../domain/entity/notification_entity.dart';

class NotificationItem extends StatelessWidget {
  final AnimationController? animationController;
  final NotificationEntity notification;
  final Function()? onTap;
  final Animation<double>? animation;

  const NotificationItem(
      {super.key,
      required this.notification,
      this.onTap,
      this.animationController,
      this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: ((context, child) => FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 50 * (1.0 - animation!.value), 0.0),
              child: InkWell(
                onTap: onTap,
                child: Row(
                  children: [
                    SizedBox(
                      width: context.width * 0.95,
                      child: DefaultListTileWidget(
                        nameHavePadding: true,
                        haveLeadingIcon: false,
                        thirdWidget: notification.link != null
                            ? Text(
                                AppLocalizations.of(context)!
                                    .translate('open_file')!,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(color: Colors.lightGreen),
                              )
                            : null,
                        name: notification.message ?? '',

                        leadingImagePath: AppAssets.notificationsGreen,
                        haveSubtitle: true,
                        haveThirdWidget: notification.link != null,
                        subTitle: Constants.fromTime(
                            context: context,
                            date: notification.createdAtDate ?? ''),
                        // thirdWidget: Row(
                        //   children: [
                        //     const Icon(
                        //       Icons.access_time_rounded,
                        //       size: 15,
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       notification.createdAtDate ?? '',
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .displaySmall!
                        //           .copyWith(
                        //               color: HexColor('#B7BFBD'), fontSize: 12),
                        //     ),
                        //     const SizedBox(
                        //       width: 30,
                        //     ),
                        //     Text(
                        //       notification.createdAtTime ?? '',
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .displaySmall!
                        //           .copyWith(
                        //             color: HexColor('#B7BFBD'),
                        //             fontSize: 12,
                        //           ),
                        //     ),
                        //   ],
                        // ),
                        tralingIcon: notification.isRead == 0
                            ? Baseline(
                                baseline: 30,
                                baselineType: TextBaseline.alphabetic,
                                child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: AppColors.primaryColor),
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
