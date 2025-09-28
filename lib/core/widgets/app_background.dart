import 'package:flutter/material.dart';
import '../utils/media_query_values.dart';
import '../utils/assets_manager.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.appBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
