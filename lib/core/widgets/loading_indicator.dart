import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double? size;
  const LoadingIndicator({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitSpinningLines(
        color: AppColors.primaryColor,
        size: size ?? 50,
      ),
    );
  }
}
