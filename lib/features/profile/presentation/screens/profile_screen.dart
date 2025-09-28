import 'dart:developer';

import 'package:ballaghny/core/models/country.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/core/widgets/appbar/default_appbar.dart';
import 'package:ballaghny/core/widgets/default_text_form_field/default_drop_down_button_form_field.dart';
import 'package:ballaghny/core/widgets/default_text_form_field/validation_mixin.dart';
import 'package:ballaghny/core/widgets/loading_indicator.dart';
import 'package:ballaghny/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:ballaghny/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:ballaghny/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:ballaghny/core/widgets/default_button.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  String selectedCountryCode = '+966'; //SA
  List<CountryModel> filteredCountries = [];

  _fillUserData() async {
    await BlocProvider.of<ProfileCubit>(context).getProfile().then((value) {
      if (!mounted) return;
      if (BlocProvider.of<ProfileCubit>(context).user != null) {
        var user = BlocProvider.of<ProfileCubit>(context).user!;

        nameController.text = user.name!;
        emailController.text = user.email!;
        genderController.text = user.gender!;

        String mobile = '';

        if (user.mobile != null) {
          phoneController.text = user.mobile!.substring(3);
          mobile = user.mobile ?? '';
        }

        // جلب جميع أكواد الدول الموجودة في التطبيق
        final allCountries = context
            .read<SettingsCubit>()
            .continentsCountries
            .map((continent) => continent.countries)
            .expand((element) => element)
            .toList();

        // ترتيب الأكواد من الأطول للأقصر لتجنب الالتباس بين الأكواد المشابهة
        final sortedCountryCodes = allCountries
            .map((country) => country.phoneCode)
            .toList()
          ..sort((a, b) => b.length.compareTo(a.length));

        // محاولة إيجاد الكود الصحيح بناءً على ترتيب الأكواد
        String? foundCountryCode;
        for (var countryCode in sortedCountryCodes) {
          if (mobile.startsWith(countryCode)) {
            foundCountryCode = countryCode;
            break;
          }
        }

        // إذا تم العثور على الكود
        if (foundCountryCode != null) {
          // تحديث الكود المحدد
          selectedCountryCode = foundCountryCode;
          // تحديث الرقم بعد الكود
          phoneController.text = mobile.substring(foundCountryCode.length);
        }

        log('selectedCountryCode: $selectedCountryCode');
        log('phoneController.text: ${phoneController.text}');
      }
    });
  }

  @override
  initState() {
    super.initState();
    _fillUserData();
    loadCountries();
  }

  loadCountries() {
    BlocProvider.of<SettingsCubit>(context).loadContinentsAndCountries();
  }

  void showCountryPicker(BuildContext context) {
    final continentsCountries =
        context.read<SettingsCubit>().continentsCountries;
    final allCountries = continentsCountries
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextFormField(
                    controller: searchController,
                    hintTxt: translator.translate('search_country'),
                    suffixIcon: Icon(Icons.search),
                    onChangedFunction: (value) {
                      setState(() {
                        filteredCountries = allCountries
                            .where((country) => country.name
                                .toLowerCase()
                                .contains(value!.toLowerCase()))
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
                          title: Text('(${country.phoneCode}) ${country.name}',
                              style: TextStyle(fontSize: 16)),
                          onTap: () {
                            setState(() {
                              selectedCountryCode = country.phoneCode;
                            });
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
    ).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var translator = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: context.height,
            decoration: BoxDecoration(
              gradient: AppColors.linearGradient,
            ),
            child: BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
              if (state is UpdateProfileDataSuccessState) {
                Constants.showToast(message: state.message);
              }
              if (state is UpdateProfileDataErrorState) {
                Constants.showError(context, state.message);
              }
              if (state is UploadImageErrorState) {
                Constants.showError(context, state.message);
              }
              if (state is UploadImageSuccessState) {
                Constants.showToast(message: state.message);
                context.read<ProfileCubit>().getProfile();
              }
            }, builder: (context, state) {
              if (state is UpdateProfileDataLoadingState ||
                  state is UploadImageLoadingState) {
                return LoadingIndicator();
              }

              if (context.read<ProfileCubit>().user == null) {
                return Container();
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        DefaultAppBar(
                          title: translator.translate('profile')!,
                          onBackTap: () {
                            context.read<ProfileCubit>().getProfile();
                            context
                                .read<LoginCubit>()
                                .getSavedLoginCredentials();
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.borderColor,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //image
                              Center(
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                        radius: 50,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: CachedNetworkImage(
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            imageUrl: context
                                                .read<ProfileCubit>()
                                                .user!
                                                .image!,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              AppAssets.whiteImage,
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            context
                                                .read<ProfileCubit>()
                                                .pickImage();
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.edit,
                                                size: 15,
                                                color: Colors.white,
                                              )),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              DefaultTextFormField(
                                controller: nameController,
                                title: translator.translate('name'),
                                hintTxt:
                                    translator.translate('enter_your_name'),
                                validationFunction: (value) {
                                  if (value == null || value.isEmpty) {
                                    return translator
                                        .translate('name_required');
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
                                hintTxt:
                                    translator.translate('enter_your_email'),
                                inputData: TextInputType.emailAddress,
                                validationFunction: (value) {
                                  if (value == null || value.isEmpty) {
                                    return translator
                                        .translate('email_required');
                                  }
                                  return null;
                                },
                                suffixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey,
                                ),
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
                              const SizedBox(height: 16),
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
                                            hintText: translator
                                                .translate('country_code'),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: HexColor('F5F5F5')),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: HexColor('F5F5F5')),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Text(
                                            selectedCountryCode, //SA
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
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
                                      // title: translator.translate('phone'),
                                      hintTxt: translator
                                          .translate('enter_your_phone'),
                                      inputData: TextInputType.phone,

                                      validationFunction: (value) {
                                        return validatePhoneNO(
                                            value, selectedCountryCode);
                                      },
                                      onChangedFunction: (value) {
                                        // if (selectedCountryCode
                                        //     .startsWith('+')) {//this function to remove +
                                        //   selectedCountryCode =
                                        //       selectedCountryCode.substring(1);
                                        // }
                                        if (value!.startsWith('0')) {
                                          phoneController.text =
                                              value.substring(1);
                                          phoneController.selection =
                                              TextSelection.fromPosition(
                                            TextPosition(
                                                offset: phoneController
                                                    .text.length),
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
                                items: ['male', 'female']
                                    .map((gender) => DropdownMenuItem(
                                          value: gender,
                                          child: Text(
                                              translator.translate(gender)!),
                                        ))
                                    .toList(),
                                value: genderController.text.isNotEmpty
                                    ? genderController.text
                                    : null,
                                hintTxt: translator.translate('select_gender'),
                                validationFunction: (value) {
                                  if (value == null) {
                                    return translator
                                        .translate('gender_required');
                                  }
                                  return null;
                                },
                                onChangedFunction: (value) {
                                  setState(() {
                                    genderController.text = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              //passwod
                              // DefaultTextFormField(
                              //   controller: passwordController,
                              //   title: translator.translate('password'),
                              //   hintTxt:
                              //       translator.translate('enter_your_password'),
                              //   inputData: TextInputType.visiblePassword,
                              //   validationFunction: validatePassword,
                              // ),
                            ],
                          ),
                        ),
                        // SizedBox(height: context.height * 0.1),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DefaultButton(
                btnLbl: translator.translate('save')!,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //todo will back if needed
                    // if (selectedCountryCode.startsWith('+')) {
                    //   selectedCountryCode = selectedCountryCode.substring(1);
                    // }
                    if (phoneController.text.startsWith('0')) {
                      phoneController.text = phoneController.text.substring(1);
                      phoneController.selection = TextSelection.fromPosition(
                        TextPosition(offset: phoneController.text.length),
                      );
                    }
                    BlocProvider.of<ProfileCubit>(context).updateProfile(
                      name: nameController.text,
                      email: emailController.text,
                      mobile: '$selectedCountryCode${phoneController.text}',
                      gender: genderController.text,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
