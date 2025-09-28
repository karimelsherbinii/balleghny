import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/hex_color.dart';

class SettingItemWidget extends StatelessWidget {
  final String title;
  final Widget icon;
  final Function()? onTap;
  final Color? backgroundIconColor;
  // final bool isSwitch;
  final Widget? trealerIcon;
  final Function()? onTapSwitch;
  final bool isDark;
  final bool isLast;
  const SettingItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    // this.isSwitch = false,
    this.onTapSwitch,
    this.isDark = false,
    this.trealerIcon,
    this.backgroundIconColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: backgroundIconColor ?? AppColors.borderColor,
                child: icon,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  // color: HexColor('222121').withOpacity(0.76),
                ),
              ),
              Spacer(),
              trealerIcon ??
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: HexColor('#5F6368'),
                    size: 16,
                  ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          if (!isLast)
            Divider(
              color: AppColors.borderColor,
              thickness: 1,
            ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
