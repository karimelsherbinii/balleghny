import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/config/routes/app_routes.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:ballaghny/core/widgets/default_text_form_field/validation_mixin.dart';
import 'package:ballaghny/features/auth/presentation/cubits/reset_password/reset_password_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/default_text_form_field/default_text_form_field.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../../core/animation/fade_animation.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/screen_container.dart';
import '../../../../core/widgets/text_form_field_header.dart';
import 'package:flutter/material.dart';

class ResetNewPasswordScreen extends StatefulWidget {
  final String? code;
  final String? mobile;
  const ResetNewPasswordScreen({super.key, this.code, this.mobile});

  @override
  State<ResetNewPasswordScreen> createState() => _ResetNewPasswordScreenState();
}

class _ResetNewPasswordScreenState extends State<ResetNewPasswordScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildBodyContent() {
    return Container(
      height: context.height,
      decoration: BoxDecoration(
        gradient: AppColors.linearGradient,
      ),
      child: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                listener: (context, state) {
              if (state is ResetPasswordFailed) {
                Constants.showError(context, state.message);
              }
              if (state is ResetPasswordSuccess) {
                Constants.showToast(message: state.message);
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              }
            }, builder: (context, state) {
              return Column(
                children: [
                  FadeAnimation(
                    1.3,
                    child:
                        Center(child: Image.asset(AppAssets.logo, width: 100)),
                  ),
                  FadeAnimation(1.6,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            top: 16, bottom: 30, left: 30, right: 30),
                        child: Text(
                          AppLocalizations.of(context)!
                              .translate('set_the_new_password')!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      )),
                  FadeAnimation(1.6,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            bottom: 30, left: 30, right: 30),
                        child: Text(
                          AppLocalizations.of(context)!
                              .translate('enter_new_password_to_login')!,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      )),
                  FadeAnimation(1.9,
                      child: TextFormFieldHeader(
                        title: AppLocalizations.of(context)!
                            .translate('new_password')!,
                      )),
                  FadeAnimation(2.2,
                      child: DefaultTextFormField(
                        controller: _passwordController,
                        hintTxt: AppLocalizations.of(context)!
                            .translate('new_password')!,
                        isPassword: true,
                        validationFunction: validateNewPassword,
                      )),
                  FadeAnimation(2.5,
                      child: TextFormFieldHeader(
                        title: AppLocalizations.of(context)!
                            .translate('confirm_new_password')!,
                      )),
                  FadeAnimation(2.8,
                      child: DefaultTextFormField(
                        controller: _confirmPasswordController,
                        hintTxt: AppLocalizations.of(context)!
                            .translate('confirm_new_password')!,
                        isPassword: true,
                        validationFunction: validateConfirmNewPassword,
                      )),
                  FadeAnimation(3.1,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: DefaultButton(
                          isLoading: state is ResetPasswordLoading,
                          btnLbl:
                              AppLocalizations.of(context)!.translate('save')!,
                          onPressed: () {
                            context.read<ResetPasswordCubit>().resetPassword(
                                  code: widget.code!,
                                  formKey: _formKey,
                                  mobile: widget.mobile!,
                                  password: _passwordController.text,
                                );
                          },
                        ),
                      )),
                ],
              );
            }),
          ),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: AppColors.appBarLinearGradient,
        ),
      ),
      elevation: 0, // Remove shadows
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          )),
    );
    return ScreenContainer(
        child: Scaffold(
      appBar: appBar,
      body: _buildBodyContent(),
    ));
  }
}
