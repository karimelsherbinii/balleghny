import 'package:flutter/material.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/core/utils/app_strings.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';

import '../utils/app_colors.dart';

appointmentCard(
  BuildContext context, {
  double? width,
  double? height,
  required Color? color,
  required Color? cardLableColor,
  required Color? detailsButtonColor,
  required Color? timeStatusColor,
  required String? coteryTitle,
  required String? timeFromTo,
  String? cashProvider,
  String? remainingTime,
  required String? acceptionStatus,
  required String? timeStatus,
  required Function() onDetailsButtonPressed,
}) {
  var translator = AppLocalizations.of(context)!;
  return Column(
    children: [
      Container(
        height: height ?? context.height * 0.20,
        width: width ?? context.width * 0.75,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // lable of card
            Container(
              margin: const EdgeInsets.all(4),
              height: height ?? context.height * 0.20,
              width: 5,
              decoration: BoxDecoration(
                  color: cardLableColor ?? AppColors.rose,
                  borderRadius: BorderRadius.circular(8)),
            ),
            //=====[card content]======
            Padding(
              padding: EdgeInsets.all(context.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: context.width * 0.65,
                    child: SizedBox(
                      width: context.width * 0.35,
                      child: Text(
                        coteryTitle ?? '',
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: HexColor('#A3A3A3'),
                        size: 17,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        timeFromTo!,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: HexColor('#A3A3A3'), fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    timeStatus!,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: timeStatusColor, fontSize: 12),
                  ),
                  SizedBox(
                    width: context.width * 0.65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: onDetailsButtonPressed,
                            child: Container(
                              height: 25,
                              width: context.width * 0.25,
                              decoration: BoxDecoration(
                                color: detailsButtonColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  '${translator.translate(AppStrings.details)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ))
                        // : const SizedBox(),
                        // const Spacer(),//TODO will be used in future
                        // Container(
                        //   height: 25,
                        //   width: width * 0.35,
                        //   decoration: BoxDecoration(
                        //     color: HexColor('#090A09'),
                        //     borderRadius: BorderRadius.circular(25),
                        //   ),
                        //   child: Center(
                        //     child: Text(
                        //       '${translator.translate('go_to_google_calendar')}',
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .displaySmall!
                        //           .copyWith(color: Colors.white, fontSize: 10),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: context.height * 0.015,
      ),
      const SizedBox(child: Divider(thickness: 1))
    ],
  );
}
