import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';

Future showImageViewDialog(
  BuildContext context,
  String mainImageUrl,
) {
  return showDialog(
      barrierColor: AppColors.bgImageViewColor,
      context: context,
      builder: (BuildContext context) {
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              mainImageUrl,
              width: context.width * 0.95,
              // height: context.height * 0.3,
            ),
          ),
          SizedBox(
            height: context.height * 0.03,
          ),
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close))
        ]);
      });
}
