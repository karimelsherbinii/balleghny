import 'package:ballaghny/config/routes/app_routes.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/widgets/appbar/default_appbar.dart';
import 'package:ballaghny/core/widgets/bottom_sheets/default_bottom_sheet.dart';
import 'package:ballaghny/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:ballaghny/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:ballaghny/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ballaghny/features/settings/presentation/widgets/setting_item_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.linearGradient,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DefaultAppBar(
                    title: AppLocalizations.of(context)!.translate('settings')!,
                    onBackTap: () => Navigator.pop(context),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 7.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<NotificationsCubit, NotificationsState>(
                          builder: (context, state) {
                            return SettingItemWidget(
                              onTap: () {
                                context
                                    .read<NotificationsCubit>()
                                    .updateNotificationSwitch();
                              },
                              backgroundIconColor: HexColor('#FCF0EA'),
                              title: AppLocalizations.of(context)!
                                  .translate('notifications')!,
                              icon: Image.asset(
                                AppAssets.notificationIcon,
                                color: AppColors.secondryColor,
                              ),
                              trealerIcon: notificationSwitchButton(
                                isNotificationsEnabled: context
                                    .read<NotificationsCubit>()
                                    .isNotificationEnabled,
                                onTapSwitch: () {
                                  context
                                      .read<NotificationsCubit>()
                                      .updateNotificationSwitch();
                                },
                              ),
                            );
                          },
                        ),
                        SettingItemWidget(
                            onTap: () {
                              onLangTap(context);
                            },
                            backgroundIconColor: HexColor('#E6F5FF'),
                            title: AppLocalizations.of(context)!
                                .translate('language')!,
                            icon: Icon(
                              Icons.language,
                              color: Colors.blue,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  onLangTap(BuildContext context) {
    showDefaultBottomSheet(
      context,
      title: AppLocalizations.of(context)!.translate('language')!,
      buttonText: AppLocalizations.of(context)!.translate('save')!,
      withSaveButton: true,
      onSaved: () {
        Navigator.pop(context);
      },
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          final languages = [
            {'code': 'ar', 'name': 'العربية'},
            {'code': 'en', 'name': 'English (USA)'},
            // {'code': 'de', 'name': 'Deutsch'},
            // {'code': 'es', 'name': 'Español'},
            // {'code': 'fr', 'name': 'Français'},
            // {'code': 'ha', 'name': 'Hausa'},
            // {'code': 'pt', 'name': 'português'},
          ];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextFormField(
                  hintTxt: AppLocalizations.of(context)!
                      .translate('search_language')!,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final lang = languages[index];
                  return ListTile(
                    onTap: () {
                      context.read<LocaleCubit>().changeLang(lang['code']!);
                      Navigator.pop(context);
                    },
                    title: Text(
                      lang['name']!,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: context
                                  .read<LocaleCubit>()
                                  .currentLangCode
                                  .contains(lang['code']!)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: context
                                  .read<LocaleCubit>()
                                  .currentLangCode
                                  .contains(lang['code']!)
                              ? AppColors.primaryColor
                              : null),
                    ),
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0,
                    dense: true,
                    leading: Radio(
                      value: lang['code'],
                      groupValue: context.read<LocaleCubit>().currentLangCode,
                      onChanged: (value) {
                        context.read<LocaleCubit>().changeLang(value as String);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget notificationSwitchButton({
    bool isNotificationsEnabled = false,
    Function()? onTapSwitch,
  }) {
    return InkWell(
        onTap: onTapSwitch,
        child: Transform(
          //make switch scale = 0.7
          transform: Matrix4.identity()..scale(0.7),
          child: Switch(
            value: isNotificationsEnabled,
            activeColor: AppColors.primaryColor,
            inactiveThumbColor: AppColors.primaryColor,
            onChanged: (value) {
              onTapSwitch!();
            },
          ),
        ));
  }
}
