import 'package:flutter/material.dart';
import 'package:ballaghny/core/widgets/loading_indicator.dart';
import '../utils/media_query_values.dart';

import '../utils/app_colors.dart';

// ignore: must_be_immutable
class CustomizedButton extends StatelessWidget {
  final String btnLbl;
  final bool enableMargin;
  final VoidCallback onPressed;
  final BorderRadiusGeometry borderRadius;
  final bool haveColorSide;
  Widget? icon;
  bool withIcon = false;
  bool haveWidth = false;
  bool haveCustomTextStyle;
  Color? lableColor;
  Color? backgroundColor;
  double? height;
  double? width;
  double margin;
  bool? isLoading;
  final double? fontSize;
  final double? loadingWidth;
  final double? loadingSize;
  CustomizedButton(
      {super.key,
      required this.btnLbl,
      this.enableMargin = true,
      this.width,
      this.height,
      this.haveWidth = true,
      this.margin = 16,
      required this.onPressed,
      this.lableColor,
      this.backgroundColor,
      this.haveCustomTextStyle = false,
      this.withIcon = false,
      this.isLoading = false,
      this.borderRadius = const BorderRadius.all(Radius.circular(24)),
      this.fontSize,
      this.loadingWidth,
      this.loadingSize,
      this.haveColorSide = false});
  CustomizedButton.withIcon(
      {super.key,
      required this.btnLbl,
      this.enableMargin = true,
      this.haveCustomTextStyle = true,
      this.backgroundColor,
      required this.icon,
      this.margin = 0,
      this.height = 25,
      required this.onPressed,
      this.lableColor,
      this.withIcon = true,
      this.haveWidth = true,
      this.isLoading = false,
      this.width = 60,
      this.borderRadius = const BorderRadius.all(Radius.circular(24)),
      this.fontSize,
      this.loadingWidth,
      this.loadingSize,
      this.haveColorSide = false});

  @override
  Widget build(BuildContext context) {
    return !isLoading!
        ? Container(
            height: height ?? context.height * 0.06,
            width: haveWidth ? width : context.width,
            margin: EdgeInsets.symmetric(horizontal: enableMargin ? margin : 0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: backgroundColor ?? AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius,
                  ),
                  side: haveColorSide
                      ? BorderSide(
                          color: AppColors.primaryColor,
                        )
                      : null),
              onPressed: onPressed,
              child: withIcon
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon ??
                            const Icon(
                              Icons.done,
                              size: 14,
                            ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          btnLbl,
                          maxLines: 1,
                          style: (haveCustomTextStyle)
                              ? Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      fontSize: fontSize ?? 12,
                                      color: lableColor ?? Colors.black)
                              : Theme.of(context).textTheme.labelLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : FittedBox(
                      child: Text(
                        btnLbl,
                        maxLines: 1,
                        style: (haveCustomTextStyle)
                            ? Theme.of(context).textTheme.labelLarge!.copyWith(
                                fontSize: fontSize ?? 12,
                                color: lableColor ?? Colors.white)
                            : Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          )
        : SizedBox(
            width: loadingWidth ?? context.width,
            child: LoadingIndicator(
              size: loadingSize ?? 50,
            ));
  }
}
