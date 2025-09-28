import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';

class DefaultListTileWidget extends StatelessWidget {
  final String name;
  final Widget? tralingIcon;
  final Widget? leadingIcon;
  final Function()? onTap;
  final bool haveLeadingIcon;
  final double paddingRight;
  final double paddingLift;
  final bool haveCustomNameTextStyle;
  final TextStyle? nameTextStyle;
  final bool haveSubtitle;
  final bool haveCircleLeading;
  final String? leadingImagePath;
  final bool haveSubtitleColor;
  final bool haveThirdWidget;
  final Widget? thirdWidget;
  final bool nameHavePadding;
  final bool minusPadding;
  final double circleAvatarRaduis;
  final Color backgroundColor;
  final String? subTitle;
  const DefaultListTileWidget({
    super.key,
    required this.name,
    this.tralingIcon,
    this.leadingIcon,
    this.onTap,
    this.haveLeadingIcon = true,
    this.paddingRight = 1,
    this.paddingLift = 2,
    this.haveCustomNameTextStyle = false,
    this.nameTextStyle,
    this.haveSubtitle = false,
    this.haveCircleLeading = true,
    this.haveSubtitleColor = false,
    this.haveThirdWidget = false,
    this.thirdWidget,
    this.nameHavePadding = false,
    this.minusPadding = false,
    this.circleAvatarRaduis = 20,
    this.backgroundColor = Colors.white,
    this.subTitle,
    this.leadingImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: context.height * 0.012,
      ),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
            visualDensity: VisualDensity(
                horizontal: minusPadding ? -4 : 0,
                vertical: minusPadding ? 2 : -1),
            dense: true,
            contentPadding:
                EdgeInsets.only(left: paddingLift, right: paddingRight),
            title: Padding(
              padding: nameHavePadding
                  ? const EdgeInsets.only(bottom: 8)
                  : const EdgeInsets.only(bottom: 0),
              child: haveThirdWidget
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name),
                        thirdWidget!,
                      ],
                    )
                  : Text(
                      name,
                      style: haveCustomNameTextStyle
                          ? nameTextStyle
                          : Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.black, fontSize: 18),
                    ),
            ),
            isThreeLine: haveThirdWidget,
            leading: haveCircleLeading
                ? CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: leadingImagePath != null
                        ? leadingImagePath!.contains('https')
                            ? NetworkImage(leadingImagePath!)
                                as ImageProvider<Object>
                            : AssetImage(leadingImagePath!)
                                as ImageProvider<Object>
                        : null,
                    radius: circleAvatarRaduis,
                    child: leadingIcon,
                  )
                : haveLeadingIcon
                    ? Container(
                        width: context.width * 0.08,
                        // height: context.height * 100,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: EdgeInsets.all(context.width * 0.05),
                          child: leadingIcon,
                        ),
                      )
                    : null,
            trailing: tralingIcon ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: HexColor('5F6368'),
                ),
            subtitle: haveSubtitle
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$subTitle',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: haveSubtitleColor
                                    ? Colors.black
                                    : HexColor('#7C908C')),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  )
                : null),
      ),
    );
  }
}
