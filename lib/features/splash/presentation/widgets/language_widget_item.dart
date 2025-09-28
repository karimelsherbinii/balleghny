import 'package:flutter/material.dart';

import '../../../../core/utils/hex_color.dart';

class LanguageWidgetItem extends StatelessWidget {
  final bool isSelected;
  final Function()? onTap;
  final String iconPath;
  final String langTitle;
  const LanguageWidgetItem(
      {super.key,
      this.isSelected = false,
      this.onTap,
      required this.iconPath,
      required this.langTitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            border: Border.all(
                color: isSelected ? HexColor('009B8A') : HexColor('E8E7E7')),
            color: Colors.white,
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          children: [
            Image.asset(iconPath),
            SizedBox(
              width: 8,
            ),
            Text(
              langTitle,
              style: TextStyle(
                color: HexColor('6A6A6A'),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            isSelected
                ? Icon(
                    Icons.done,
                    color: HexColor('009B8A'),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
