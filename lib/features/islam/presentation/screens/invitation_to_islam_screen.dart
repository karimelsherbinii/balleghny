import 'dart:developer';

import 'package:ballaghny/config/routes/app_routes.dart';
import 'package:ballaghny/core/models/country.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/core/widgets/appbar/default_appbar.dart';
import 'package:ballaghny/core/widgets/default_text_form_field/validation_mixin.dart';
import 'package:ballaghny/core/widgets/loading_indicator.dart';
import 'package:ballaghny/features/bottom_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:ballaghny/features/home/presentation/screens/home_body.dart';
import 'package:ballaghny/features/islam/presentation/cubit/islam_cubit.dart';
import 'package:ballaghny/features/settings/data/models/dynamic_model.dart';
import 'package:ballaghny/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ballaghny/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:ballaghny/core/widgets/default_button.dart';
import 'package:ballaghny/core/widgets/default_drop_down_button_form_field.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvitationToIslamScreen extends StatefulWidget {
  const InvitationToIslamScreen({super.key});

  @override
  State<InvitationToIslamScreen> createState() =>
      _InvitationToIslamScreenState();
}

class _InvitationToIslamScreenState extends State<InvitationToIslamScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController socialMediaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  String? selectedGender;
  DynamicModel? selectedCountry;
  DynamicModel? selectedLanguage;
  DynamicModel? selectedReligion;
  bool agreeToPolicy = false;

  List<CountryModel> filteredCountries = [];

  //get languages
  getData() async {
    if (!mounted) return;
    BlocProvider.of<SettingsCubit>(context).getLanguages();
    BlocProvider.of<SettingsCubit>(context).getCountries();
    BlocProvider.of<SettingsCubit>(context).getNationalities();
    BlocProvider.of<SettingsCubit>(context).getReligions();
  }

  loadCountries() {
    BlocProvider.of<SettingsCubit>(context).loadContinentsAndCountries();
  }

  // getCountries() {
  //   context.read<SettingsCubit>().getAllCountries();
  // }

  @override
  initState() {
    super.initState();
    getData();
    loadCountries();
  }

  void showCountryPicker(BuildContext context) {
    final continentsCountries =
        context.read<SettingsCubit>().continentsCountries;
    final allCountries =
        continentsCountries
            .map((continent) => continent.countries)
            .expand((element) => element)
            .toList();
    filteredCountries = allCountries;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      builder: (BuildContext context) {
        var translator = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextFormField(
                    controller: searchController,
                    hintTxt: translator.translate('search_country'),
                    suffixIcon: Icon(Icons.search),
                    onChangedFunction: (value) {
                      setState(() {
                        filteredCountries =
                            allCountries
                                .where(
                                  (country) => country.name
                                      .toLowerCase()
                                      .contains(value!.toLowerCase()),
                                )
                                .toList();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];
                        return ListTile(
                          title: Text(
                            '(${country.phoneCode}) ${country.name}',
                            style: TextStyle(fontSize: 16),
                          ),
                          onTap: () {
                            context.read<SettingsCubit>().selectCountryCode(
                              country.phoneCode,
                            );
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var translator = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.homeBg),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocConsumer<IslamCubit, IslamState>(
              listener: (context, state) {
                if (state is InviteToIslamErrorState) {
                  Constants.showError(context, state.message);
                }
                if (state is InviteToIslamSuccessState) {
                  Constants.showOptionstoConfirm(
                    context,
                    msg: state.message,
                    withCancel: false,
                    onYesTap: () async {
                      log('onYesTap');
                      final bottomNavCubit =
                          context.read<BottomNavigationCubit>();

                      bottomNavCubit.upadateBottomNavIndex(0);

                      await Navigator.pushReplacementNamed(
                        context,
                        Routes.homeScreen,
                        arguments: {'widget': HomeBodyScreen()},
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is InviteToIslamLoadingState) {
                  return LoadingIndicator();
                }
                return BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    if (state is GetContinentsLoadingState) {
                      return LoadingIndicator();
                    }

                    if (state is GetAllCountriesLoadingState) {
                      return LoadingIndicator();
                    }

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            DefaultAppBar(
                              title:
                                  translator.translate(
                                    'non_muslim_information',
                                  )!,
                            ),
                            SizedBox(height: 20),
                            DefaultTextFormField(
                              controller: nameController,
                              title: translator.translate('name'),
                              hintTxt: translator.translate('enter_your_name'),
                              validationFunction: (value) {
                                if (value == null || value.isEmpty) {
                                  return translator.translate('name_required');
                                }
                                return null;
                              },
                              suffixIcon: Icon(
                                Icons.person_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            DefaultTextFormField(
                              controller: emailController,
                              title: translator.translate('email'),
                              hintTxt: translator.translate('enter_your_email'),
                              inputData: TextInputType.emailAddress,
                              suffixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                              validationFunction: (value) {
                                if (value != null && value.isNotEmpty) {
                                  final emailRegex = RegExp(r'^.+@.+\..+?$');
                                  if (!emailRegex.hasMatch(value)) {
                                    return translator.translate(
                                      'invalid_email',
                                    );
                                  }
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              translator.translate('phone_number')!,
                              style: TextStyle(
                                fontSize: 14,
                                color: HexColor('78828A'),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      onTap: () => showCountryPicker(context),
                                      child: InputDecorator(
                                        decoration: InputDecoration(
                                          hintText: translator.translate(
                                            'country_code',
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: HexColor('F5F5F5'),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: HexColor('F5F5F5'),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          context
                                              .read<SettingsCubit>()
                                              .selectedCountryCode, //SA
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 5,
                                  child: DefaultTextFormField(
                                    controller: phoneController,
                                    hintTxt: 'xx51377733',
                                    inputData: TextInputType.number,
                                    validationFunction: (value) {
                                      final selectedCode =
                                          context
                                              .read<SettingsCubit>()
                                              .selectedCountryCode;
                                      if (!(selectedCode.startsWith('+966') ||
                                          selectedCode.startsWith('05'))) {
                                        return 'يُسمح فقط بأرقام الجوال السعودية (+966 أو 05)';
                                      }
                                      return null;
                                    },
                                    onChangedFunction: (value) {
                                      final selectedCode =
                                          context
                                              .read<SettingsCubit>()
                                              .selectedCountryCode;
                                      if (selectedCode == '+966' &&
                                          value != null &&
                                          value.startsWith('05')) {
                                        // تصحيح تلقائي: حذف الصفر الأول إذا كتب 05
                                        final corrected = value.substring(1);
                                        phoneController.text = corrected;
                                        phoneController.selection =
                                            TextSelection.fromPosition(
                                              TextPosition(
                                                offset: corrected.length,
                                              ),
                                            );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            DefaultDropdownButtonFormField.withTitle(
                              title: translator.translate('gender')!,
                              items:
                                  ['male', 'female']
                                      .map(
                                        (gender) => DropdownMenuItem(
                                          value: gender,
                                          child: Text(
                                            translator.translate(gender)!,
                                          ),
                                        ),
                                      )
                                      .toList(),
                              value: selectedGender,
                              hintTxt: translator.translate('select_gender'),
                              validationFunction: (value) {
                                if (value == null) {
                                  return translator.translate(
                                    'gender_required',
                                  );
                                }
                                return null;
                              },
                              onChangedFunction: (value) {
                                setState(() {
                                  selectedGender = value;
                                  log('SelectedGender: ');
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            DefaultDropdownButtonFormField.withTitle(
                              title: translator.translate('country')!,
                              items:
                                  context
                                      .read<SettingsCubit>()
                                      .countries
                                      .map(
                                        (country) => DropdownMenuItem(
                                          value: country,
                                          child: Text(country.name),
                                        ),
                                      )
                                      .toList(),
                              value: selectedCountry,
                              hintTxt: translator.translate('select_country'),
                              validationFunction: (value) {
                                if (value == null) {
                                  return translator.translate(
                                    'country_required',
                                  );
                                }
                                return null;
                              },
                              onChangedFunction: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            DefaultTextFormField(
                              title: translator.translate('city')!,
                              hintTxt: translator.translate('enter_your_city'),
                              controller: cityController,
                              suffixIcon: Icon(
                                Icons.location_city_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            DefaultDropdownButtonFormField.withTitle(
                              title: translator.translate('language')!,
                              items:
                                  context
                                      .read<SettingsCubit>()
                                      .languages
                                      .map(
                                        (language) => DropdownMenuItem(
                                          value: language,
                                          child: Text(language.name),
                                        ),
                                      )
                                      .toList(),
                              value: selectedLanguage,
                              hintTxt: translator.translate('select_language'),
                              validationFunction: (value) {
                                if (value == null) {
                                  return translator.translate(
                                    'language_required',
                                  );
                                }
                                return null;
                              },
                              onChangedFunction: (value) {
                                setState(() {
                                  selectedLanguage = value;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            DefaultDropdownButtonFormField.withTitle(
                              title: translator.translate('religion')!,
                              items:
                                  context
                                      .read<SettingsCubit>()
                                      .religions
                                      .map(
                                        (religion) => DropdownMenuItem(
                                          value: religion,
                                          child: Text(religion.name),
                                        ),
                                      )
                                      .toList(),
                              value: selectedReligion,
                              hintTxt: translator.translate('select_religion'),
                              validationFunction: (value) {
                                if (value == null) {
                                  return translator.translate(
                                    'religion_required',
                                  );
                                }
                                return null;
                              },
                              onChangedFunction: (value) {
                                setState(() {
                                  selectedReligion = value;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            DefaultTextFormField(
                              controller: socialMediaController,
                              title: translator.translate('add_social_media'),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Checkbox(
                                  value: agreeToPolicy,
                                  onChanged: (value) {
                                    setState(() {
                                      agreeToPolicy = value!;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    translator.translate('invited_agreed')!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            DefaultButton(
                              btnLbl: translator.translate('submit')!,
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    agreeToPolicy) {
                                  BlocProvider.of<IslamCubit>(
                                    context,
                                  ).inviteToIslam(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phoneNumber:
                                        '${context.read<SettingsCubit>().selectedCountryCode}${phoneController.text}',
                                    gender: selectedGender,
                                    country: selectedCountry!.id.toString(),
                                    city: cityController.text,
                                    language: selectedLanguage!.id.toString(),
                                    religion: selectedReligion!.id.toString(),
                                    socialMediaAccount:
                                        socialMediaController.text,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        translator.translate(
                                          'please_fill_all_fields',
                                        )!,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
