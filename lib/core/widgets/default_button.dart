import 'package:flutter/material.dart';
import '../utils/media_query_values.dart';
import '../utils/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final String btnLbl;
  final VoidCallback onPressed;
  final BorderRadiusGeometry borderRadius;
  final TextStyle? style;
  final double? height;
  final double? margin;
  final bool withIcon;
  final Color? color;
  final Widget icon;
  final Widget? endIcon;
  final bool isLoading;
  final bool isOutlined;

  const DefaultButton({
    super.key,
    required this.btnLbl,
    required this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(50)),
    this.style,
    this.height,
    this.margin,
    this.color,
    this.withIcon = false,
    this.icon = const SizedBox(),
    this.endIcon,
    this.isLoading = false,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 56,
      width: context.width,
      margin: EdgeInsets.symmetric(horizontal: margin ?? 16),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: isOutlined
              ? BorderSide(color: color ?? AppColors.primaryColor, width: 1.5)
              : BorderSide.none, // تحديد الإطار إذا كان `isOutlined` مفعلاً
          backgroundColor:
              isOutlined ? Colors.transparent : color ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        onPressed: () => onPressed(),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : withIcon
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        btnLbl,
                        style: style ??
                            Theme.of(context).textTheme.labelLarge!.copyWith(
                                  color: isOutlined
                                      ? AppColors.primaryColor
                                      : Colors.white,
                                ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : endIcon != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            btnLbl,
                            style: style ??
                                Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: isOutlined
                                          ? AppColors.primaryColor
                                          : Colors.white,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          endIcon!,
                        ],
                      )
                    : Text(
                        btnLbl,
                        style: style ??
                            Theme.of(context).textTheme.labelLarge!.copyWith(
                                  color: isOutlined
                                      ? AppColors.primaryColor
                                      : Colors.white,
                                ),
                        textAlign: TextAlign.center,
                      ),
      ),
    );
  }
}
