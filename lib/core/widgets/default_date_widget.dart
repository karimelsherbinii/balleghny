import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import '../../../../core/utils/app_colors.dart';

class DefaultDateWidget extends StatelessWidget {
  final double width;
  final double height;
  final bool hasDateIcon;
  final String? iconPath;
  final String? title;
  final String? subTitle;
  final Image? topDataIcon;
  final bool? isFirst;
  final List<BoxShadow>? boxShadow;
  final double? textBaseline;
  const DefaultDateWidget({
    super.key,
    this.width = 20,
    this.height = 60,
    this.iconPath,
    this.hasDateIcon = false,
    this.isFirst,
    this.title,
    this.subTitle,
    this.boxShadow,
    this.topDataIcon,
    this.textBaseline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, //* 0.18,
      height: height,
      margin: EdgeInsets.only(left: context.width * 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 7,
                offset: const Offset(0, 15), // changes position of shadow
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(0, 90),
                blurRadius: 0,
              ),
            ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: context.height * 0.02,
          ),
          isFirst ?? false
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(AppAssets.calendar))
              : Container(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: hasDateIcon
                  ? Image.asset(
                      iconPath ?? '',
                    )
                  : Baseline(
                      baseline: textBaseline ?? 120,
                      baselineType: TextBaseline.alphabetic,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: AppColors.hintColor, fontSize: 12),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          FittedBox(
                            child: Text(subTitle ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: AppColors.hintColor,
                                        fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
