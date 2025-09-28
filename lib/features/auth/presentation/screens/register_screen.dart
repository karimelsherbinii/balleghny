import 'package:ballaghny/core/models/country.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/core/widgets/default_text_form_field/default_drop_down_button_form_field.dart';
import 'package:ballaghny/core/widgets/loading_indicator.dart';
import 'package:ballaghny/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:ballaghny/features/home/presentation/screens/home_screen.dart';
import 'package:ballaghny/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/features/home/presentation/screens/home_body.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/animation/fade_animation.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_text_form_field/default_text_form_field.dart';
import '../../../../core/widgets/default_text_form_field/validation_mixin.dart';
import '../../../../core/widgets/screen_container.dart';
import '../../../../core/widgets/text_form_field_header.dart';
import '../../../../config/locale/app_localizations.dart';
import '../cubits/register/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _isChecked = false;

  String? _selectedGender;
  late List<String> _genders;

  String _selectedCountryCode = '+966'; //SA
  List<CountryModel> _filteredCountries = [];

  loadCountries() {
    BlocProvider.of<SettingsCubit>(context).loadContinentsAndCountries();
  }

  // getCountries() {
  //   context.read<SettingsCubit>().getAllCountries();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _genders = [
      AppLocalizations.of(context)!.translate('male')!,
      AppLocalizations.of(context)!.translate('female')!,
    ];
  }

  @override
  void initState() {
    super.initState();
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

    _filteredCountries = allCountries;

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
                    controller: _searchController,
                    hintTxt: translator.translate('search_country'),
                    suffixIcon: Icon(Icons.search),
                    onChangedFunction: (value) {
                      setState(() {
                        _filteredCountries =
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
                      itemCount: _filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = _filteredCountries[index];
                        return ListTile(
                          title: Text(
                            '(${country.phoneCode}) ${country.name}',
                            style: TextStyle(fontSize: 16),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedCountryCode = country.phoneCode;
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
    );
  }

  Widget _buildBodyContent(RegisterState state) {
    var translator = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Form(
        autovalidateMode: autovalidateMode(state),
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(child: Image.asset(AppAssets.logo, width: 100)),
            const SizedBox(height: 16),
            Center(
              child: Text(
                translator.translate('register')!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                translator.translate('register_title')!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 16),

            /// الاسم
            FadeAnimation(
              1.2,
              child: TextFormFieldHeader(title: translator.translate('name')!),
            ),
            FadeAnimation(
              1.8,
              child: DefaultTextFormField(
                autovalidateMode: autovalidateMode(state),
                hintTxt: translator.translate('name')!,
                inputData: TextInputType.name,
                controller: _nameController,
                validationFunction: validateFirstName,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
            ),

            /// الايميل
            FadeAnimation(
              1.2,
              child: TextFormFieldHeader(title: translator.translate('email')!),
            ),
            FadeAnimation(
              1.8,
              child: DefaultTextFormField(
                autovalidateMode: autovalidateMode(state),
                hintTxt: translator.translate('email')!,
                inputData: TextInputType.emailAddress,
                controller: _emailController,
                validationFunction: validateEmail,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
            ),

            /// رقم الهاتف
            FadeAnimation(
              1.2,
              child: TextFormFieldHeader(
                title: translator.translate('phone_number')!,
              ),
            ),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                if (state is GetContinentsLoadingState) {
                  return LoadingIndicator();
                }
                // if (state is GetAllCountriesSuccessState) {
                //   getCountries();
                // }

                if (state is GetAllCountriesLoadingState) {
                  return LoadingIndicator();
                }

                return FadeAnimation(
                  1.81,
                  child: Row(
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
                                hintText: translator.translate('country_code'),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: HexColor('F5F5F5'),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: HexColor('F5F5F5'),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                _selectedCountryCode, //SA
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
                          controller: _phoneController,
                          // title: translator.translate('phone_number'),
                          hintTxt: '1151377733',
                          inputData: TextInputType.phone,

                          validationFunction: (value) {
                            return validatePhoneNO(value, _selectedCountryCode);
                          },
                          onChangedFunction: (value) {
                            if (value!.startsWith('0')) {
                              _phoneController.text = value.substring(1);
                              _phoneController
                                  .selection = TextSelection.fromPosition(
                                TextPosition(
                                  offset: _phoneController.text.length,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            //gender
            FadeAnimation(
              1.2,
              child: TextFormFieldHeader(
                title: translator.translate('gender')!,
              ),
            ),
            FadeAnimation(
              1.81,
              child: Row(
                children: [
                  Expanded(
                    child: DefaultDropdownButtonFormField.withTitle(
                      title: translator.translate('gender')!,
                      items:
                          ['male', 'female']
                              .map(
                                (gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(translator.translate(gender)!),
                                ),
                              )
                              .toList(),
                      value: _selectedGender,
                      hintTxt: translator.translate('select_gender'),
                      validationFunction: (value) {
                        if (value == null) {
                          return translator.translate('gender_required');
                        }
                        return null;
                      },
                      onChangedFunction: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// كلمة المرور
            FadeAnimation(
              2.0,
              child: TextFormFieldHeader(
                title: translator.translate('password')!,
              ),
            ),
            FadeAnimation(
              2.5,
              child: DefaultTextFormField(
                autovalidateMode: autovalidateMode(state),
                hintTxt: translator.translate('password')!,
                isPassword: true,
                controller: _passwordController,
                validationFunction: validatePassword,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
            ),

            /// تأكيد كلمة المرور
            FadeAnimation(
              3.0,
              child: TextFormFieldHeader(
                title: translator.translate('confirm_password')!,
              ),
            ),
            FadeAnimation(
              3.4,
              child: DefaultTextFormField(
                autovalidateMode: autovalidateMode(state),
                hintTxt: translator.translate('confirm_password')!,
                isPassword: true,
                validationFunction: validateConfirmPassword,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
            ),

            /// الموافقة على الشروط
            FadeAnimation(
              3.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _isChecked,
                    checkColor: Colors.white,
                    activeColor: AppColors.primaryColor,
                    splashRadius: 20.0,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  Text(
                    translator.translate('accepr_terms_and_conditions')!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            /// زر التسجيل
            FadeAnimation(
              3.8,
              child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: DefaultButton(
                  isLoading: context.watch<RegisterCubit>().isloading,
                  color:
                      _isChecked
                          ? AppColors.primaryColor
                          : AppColors.primaryColor.withAlpha(
                            (0.5 * 255).toInt(),
                          ),
                  btnLbl: translator.translate('register')!,
                  onPressed: () {
                    if (!_isChecked) return;

                    _firebaseMessaging.getToken().then((token) async {
                      if (!mounted) return;

                      final fullPhoneNumber =
                          '$_selectedCountryCode${_phoneController.text}';

                      BlocProvider.of<RegisterCubit>(context).register(
                        formKey: _formKey,
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        phone: fullPhoneNumber, // <-- رقم بكود الدولة
                        gender:
                            _selectedGender == translator.translate('male')!
                                ? AppStrings.male
                                : AppStrings.female,
                        // firebaseToken: token,
                        // deviceType: Platform.isAndroid ? AppStrings.android : AppStrings.ios,
                      );
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: context.height * 0.01),
            // FadeAnimation(
            //   3.0,
            //   child: Container(
            //     margin: const EdgeInsets.only(bottom: 16),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         SizedBox(
            //           width: context.width * 0.2,
            //           child: const Divider(thickness: 1, color: Colors.grey),
            //         ),
            //         const SizedBox(width: 8),
            //         // Text(
            //         //   translator.translate('or_login_with')!,
            //         //   style: Theme.of(context).textTheme.displayMedium,
            //         // ),
            //         // const SizedBox(width: 8),
            //         // SizedBox(
            //         //   width: context.width * 0.2,
            //         //   child: const Divider(thickness: 1, color: Colors.grey),
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
            // FadeAnimation(
            //   3.1,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       InkWell(
            //         // onTap: () {},
            //         child: Image.asset(AppAssets.googleIcon),
            //       ),
            //       const SizedBox(width: 16),
            //       InkWell(
            //         // onTap: () {},
            //         child: Image.asset(AppAssets.xIcon),
            //       ),
            //       const SizedBox(width: 16),
            //       InkWell(
            //         // onTap: () {},
            //         child: Image.asset(AppAssets.facebookIcon),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: context.height * 0.02),

            /// لا تملك حساب؟ تسجيل الدخول
            FadeAnimation(
              4.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: translator.translate("don't_have_account?")!,
                            style: Theme.of(context).textTheme.displayMedium,
                            children: <InlineSpan>[
                              const TextSpan(text: '  '),
                              TextSpan(
                                text: translator.translate("login")!,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: AppColors.primaryColor),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap =
                                          () => Navigator.pushNamed(
                                            context,
                                            Routes.loginRoute,
                                          ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.homeScreen,
                          arguments: {'widget': HomeBodyScreen()},
                        );
                      },
                      child: Text(
                        translator.translate('contiue_as_visitor')!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AutovalidateMode autovalidateMode(RegisterState state) {
    if (state is RegisterValidatation) {
      return state.isValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled;
    }
    return AutovalidateMode.disabled;
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(AppLocalizations.of(context)!.translate('create_account')!),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
      ),
      actions: [
        InkWell(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(AppLocalizations.of(context)!.translate('skip')!),
          ),
          onTap:
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.unloginMainRoute,
                (Route<dynamic> route) => false,
              ),
        ),
      ],
    );

    return ScreenContainer(
      child: Scaffold(
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              context.read<LoginCubit>().authenticatedUser = state.user;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => const HomeScreen(mainBody: HomeBodyScreen()),
                ),
              );
              Constants.showToast(message: state.message);
            } else if (state is RegisterFailed) {
              Constants.showError(context, state.message);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildBodyContent(state),
              ),
            );
          },
        ),
      ),
    );
  }
}
