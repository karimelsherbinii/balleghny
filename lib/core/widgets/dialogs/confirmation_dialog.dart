import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/app_strings.dart';
import '../../../config/locale/app_localizations.dart';
import '../../utils/app_colors.dart';

class ConfirmationDialog extends StatelessWidget {
  final String alertMsg;
  final VoidCallback onTapConfirm;

  const ConfirmationDialog(
      {super.key, required this.alertMsg, required this.onTapConfirm});
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Text(
        alertMsg,
        style: TextStyle(
            fontFamily: AppStrings.appFont,
            color: AppColors.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
      actions: <Widget>[
        TextButton(
            style: Theme.of(context).textButtonTheme.style,
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context)!.translate('cancel')!,
            )),
        TextButton(
          style: Theme.of(context).textButtonTheme.style,
          onPressed: () => onTapConfirm(),
          child: Text(AppLocalizations.of(context)!.translate('ok')!),
        ),
      ],
    );
  }
}
