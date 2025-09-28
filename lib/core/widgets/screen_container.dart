import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ScreenContainer extends StatelessWidget {
  final Widget child;
  const ScreenContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      
        decoration: BoxDecoration(
          gradient: AppColors.linearGradient,
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: child,
        ));
  }
}
