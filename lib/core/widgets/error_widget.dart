import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:ballaghny/core/widgets/default_button.dart';

import '../../config/locale/app_localizations.dart';
import '../utils/app_colors.dart';
import '../utils/media_query_values.dart';

class DefaultErrorWidget extends StatelessWidget {
  final String msg;
  final VoidCallback? onRetryPressed;
  const DefaultErrorWidget({super.key, required this.msg, this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.warning_amber_rounded,
            color: AppColors.primaryColor,
            size: 120,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            Constants.handleErrorMsg(context, msg) ??
                AppLocalizations.of(context)!.translate('no_data').toString(),
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              AppLocalizations.of(context)!.translate('try_again')!,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )),
        Container(
            width: context.width * 0.55,
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: DefaultButton(
                btnLbl:
                    AppLocalizations.of(context)!.translate('reload_screen')!,
                onPressed: () {
                  if (onRetryPressed != null) {
                    onRetryPressed!();
                  }
                }))
      ],
    );
  }
}
