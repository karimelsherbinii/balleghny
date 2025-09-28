import 'package:flutter/material.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/config/routes/app_routes.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/core/widgets/default_button.dart';

class AskToLoginScreen extends StatefulWidget {
  const AskToLoginScreen({super.key});

  @override
  State<AskToLoginScreen> createState() => _AskToLoginScreenState();
}

class _AskToLoginScreenState extends State<AskToLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   ImageAssets.askToLogin,
          //   height: 100,
          //   width: 100,
          // ),
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Text(
              AppLocalizations.of(context)!.translate('excuse_me')!,
              style: const TextStyle(
                  color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context)!.translate('you_should_login')!,
            style: TextStyle(
                color: HexColor('#383032'),
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 50,
          ),
          DefaultButton(
              btnLbl: AppLocalizations.of(context)!.translate('login')!,
              onPressed: () {
                Navigator.pushNamed(context, Routes.loginRoute);
              }),
          const SizedBox(
            height: 20,
          ),
          DefaultButton(
              btnLbl: AppLocalizations.of(context)!.translate('register')!,
              onPressed: () {
                Navigator.pushNamed(context, Routes.registerRoute);
              })
        ],
      ),
    );
  }
}
