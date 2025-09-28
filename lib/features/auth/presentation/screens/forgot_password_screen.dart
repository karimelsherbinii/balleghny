import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/features/auth/presentation/cubits/verify/verify_cubit.dart';
import 'package:intl_phone_number_input_v2/intl_phone_number_input.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/animation/fade_animation.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_text_form_field/validation_mixin.dart';
import '../../../../core/widgets/screen_container.dart';
import '../../../../core/widgets/text_form_field_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  PhoneNumber finalPhoneNumber = PhoneNumber(isoCode: 'SA'); // افتراضيًا مصر
  final _phoneController = TextEditingController();
  Widget _buildBodyContent() {
    var translator = AppLocalizations.of(context)!;
    return Container(
      height: context.height,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.linearGradient,
      ),
      child: Center(
        child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Center(child: Image.asset(AppAssets.logo, width: 100)),
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!
                              .translate('forgot_password')!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .translate('enter_your_email_to_reset_password')!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FadeAnimation(1.3,
                          child: TextFormFieldHeader(
                            title: AppLocalizations.of(context)!
                                .translate('phone_number')!,
                          )),
                      FadeAnimation(
                        1.81,
                        child: InternationalPhoneNumberInput(
                          selectorTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                          onInputChanged: (PhoneNumber number) {
                            finalPhoneNumber = number;
                          },
                          onInputValidated: (bool value) {
                            // هنا يمكنك التأكد إن الرقم صالح أو لا
                            // print('is phone number valid? $value');
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DROPDOWN,
                            showFlags: true,
                          ),
                          ignoreBlank: false,
                          textFieldController: _phoneController,
                          keyboardType: TextInputType.phone,
                          inputDecoration: InputDecoration(
                            hintText: translator.translate('phone_number')!,
                            suffixIcon: Image.asset(AppAssets.mobileIcon),
                            //code color
                            counterStyle: TextStyle(color: Colors.red),
                          ),
                          initialValue: finalPhoneNumber,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<VerifyCubit, VerifyState>(
                          builder: (context, state) {
                        return FadeAnimation(2.8,
                            child: Container(
                                margin:
                                    const EdgeInsets.only(top: 30, bottom: 16),
                                child: DefaultButton(
                                    margin: 0,
                                    isLoading: state is SendCodeLoadingState,
                                    btnLbl: AppLocalizations.of(context)!
                                        .translate('send')!,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<VerifyCubit>(context)
                                            .sendCode(
                                          mobile: finalPhoneNumber.phoneNumber
                                              .toString(),
                                        );
                                      }
                                    })));
                      }),
                    ],
                  ),
                ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
        child: Scaffold(

            // ignore: deprecated_member_use
            body: BlocConsumer<VerifyCubit, VerifyState>(
      listener: (context, state) {
        if (state is SendCodeSuccessState) {
          Constants.showToast(message: state.message);
          Navigator.of(context)
              .pushNamed(Routes.verifyPasswordCode, arguments: {
            'mobile': finalPhoneNumber.phoneNumber.toString(),
          });
        }
      },
      builder: (context, state) {
        return _buildBodyContent();
      },
    )));
  }
}
