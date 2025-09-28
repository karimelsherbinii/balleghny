import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../../core/widgets/default_button.dart';
import '../../features/splash/presentation/cubit/locale_cubit.dart';

class ChangeAppLanguage extends StatefulWidget {
  const ChangeAppLanguage({
    super.key,
  });

  @override
  State<ChangeAppLanguage> createState() => _ChangeAppLanguageState();
}

class _ChangeAppLanguageState extends State<ChangeAppLanguage> {
  int _radioSelected = 1;

  _reloadAppFromScratch() {
    Navigator.pop(context);
    Phoenix.rebirth(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.35,
                    ),
                    SizedBox(
                      child: Text(
                        AppLocalizations.of(context)!.translate('language')!,
                        style: Theme.of(context).appBarTheme.titleTextStyle,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      child: const Icon(
                        Icons.close,
                        size: 22,
                        color: Color(0xff05332B),
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                );
              }),
              const SizedBox(
                height: 20,
              ),
              _buildLanguageTile(1, 'English'),
              Divider(
                color: AppColors.hintColor,
              ),
              _buildLanguageTile(2, 'French'),
              Divider(
                color: AppColors.hintColor,
              ),
              _buildLanguageTile(3, 'Spanish'),
              Divider(
                color: AppColors.hintColor,
              ),
              _buildLanguageTile(4, 'Portuguese'),
              Divider(
                color: AppColors.hintColor,
              ),
              _buildLanguageTile(5, 'فارسي'),
              Divider(
                color: AppColors.hintColor,
              ),
              _buildLanguageTile(6, 'Hausa'),
              const SizedBox(height: 10),
              DefaultButton(
                //
                btnLbl: AppLocalizations.of(context)!.translate('save')!,
                onPressed: () {
                  switch (_radioSelected) {
                    case 1:
                      BlocProvider.of<LocaleCubit>(context).toEnglish();
                      break;
                    // case 2:
                    //   BlocProvider.of<LocaleCubit>(context).toFrench();
                    //   break;
                    // case 3:
                    //   BlocProvider.of<LocaleCubit>(context).toSpanish();
                    //   break;
                    // case 4:
                    //   BlocProvider.of<LocaleCubit>(context).toPortuguese();
                    //   break;
                    // case 5:
                    //   BlocProvider.of<LocaleCubit>(context).toFarsi();
                    //   break;
                    // case 6:
                    //   BlocProvider.of<LocaleCubit>(context).toHausa();
                    //   break;

                    default:
                      break;
                  }
                  _reloadAppFromScratch();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildLanguageTile(int value, String language) {
    return InkWell(
      onTap: () {
        setState(() {
          _radioSelected = value;
        });
      },
      child: ListTile(
        title: Text(language, style: Theme.of(context).textTheme.headlineLarge),
        leading: Radio(
          focusColor: AppColors.primaryColor,
          fillColor: WidgetStateColor.resolveWith(
            (states) => AppColors.primaryColor,
          ),
          value: value,
          groupValue: _radioSelected,
          onChanged: (int? selectedValue) {
            setState(() {
              _radioSelected = selectedValue!;
            });
          },
        ),
      ),
    );
  }
}
