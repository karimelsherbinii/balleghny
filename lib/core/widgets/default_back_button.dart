import 'package:flutter/material.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/hex_color.dart';

import '../utils/assets_manager.dart';

class DefaultBackButton extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final Function()? onTap;

  const DefaultBackButton({
    super.key,
    this.color,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var isArabic = AppLocalizations.of(context)!.isArLocale;
    return InkWell(
        onTap: onTap ?? () => Navigator.pop(context),
        child: isArabic
            ? Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: backgroundColor ?? HexColor('F5F5F5'),
                  shape: BoxShape.circle,
                ),
                child:
                    Icon(Icons.arrow_back, color: color ?? AppColors.greyColor))
            : RotatedBox(
                quarterTurns: 2,
                child: Image.asset(AppAssets.backIcon),
              ));
  }
}
