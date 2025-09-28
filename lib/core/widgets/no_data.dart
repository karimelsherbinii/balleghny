import 'package:flutter/material.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';

class NoData extends StatelessWidget {
  final String? message;
  final double height;
  const NoData({super.key, this.message, this.height = 250});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.noData,
              height: height,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(message ?? AppLocalizations.of(context)!.translate('no_data')!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
