import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class OutlineShape extends StatelessWidget {
  final String image;
  final Color? color;
  const OutlineShape({super.key, required this.image, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: color ?? AppColors.primaryColor,
        ),
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        image,
        height: 12,
      ),
    );
  }
}
