import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/config/routes/app_routes.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/widgets/default_button.dart';
import 'package:flutter/material.dart';

class MustLoginScreen extends StatelessWidget {
  final String? message;
  const MustLoginScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.homeBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  message ??
                      AppLocalizations.of(context)!.translate('must_login')!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultButton(
                  btnLbl: AppLocalizations.of(context)!.translate('login')!,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.loginRoute);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
