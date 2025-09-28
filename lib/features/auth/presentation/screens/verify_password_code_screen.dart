import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/features/auth/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:ballaghny/features/auth/presentation/screens/reset_new_password_screen.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../../core/animation/fade_animation.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_text_form_field/validation_mixin.dart';
import '../../../../core/widgets/screen_container.dart';
import '../../../../core/widgets/text_form_field_header.dart';

class VerifyPasswordCodeScreen extends StatefulWidget {
  final String mobile;

  const VerifyPasswordCodeScreen({
    super.key,
    required this.mobile,
  });

  @override
  State<VerifyPasswordCodeScreen> createState() =>
      _VerifyPasswordCodeScreenState();
}

class _VerifyPasswordCodeScreenState extends State<VerifyPasswordCodeScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
                              .translate('verify_code')!,
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
                        AppLocalizations.of(context)!.translate(
                            'please_enter_your_code_from_your_email')!,
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
                                .translate('code')!,
                          )),
                      FadeAnimation(
                        1.6,
                        child: Constants.getPinPutWidget(
                          code: _codeController.text,
                          controller: _codeController,
                          validatorFunction: (string) {
                            if (string!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('please_enter_code')!;
                            }
                            return "";
                          },
                          onComplete: (pin) {
                            _codeController.text = pin!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                          builder: (context, state) {
                        return FadeAnimation(2.8,
                            child: Container(
                                margin:
                                    const EdgeInsets.only(top: 30, bottom: 16),
                                child: DefaultButton(
                                    margin: 0,
                                    isLoading:
                                        state is VerifyPasswordCodeLoading,
                                    btnLbl: AppLocalizations.of(context)!
                                        .translate('send')!,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResetNewPasswordScreen(
                                                      code:
                                                          _codeController.text,
                                                      mobile: widget.mobile,
                                                    )));
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
            body: WillPopScope(
      onWillPop: () async {
        return Constants.showExitDialog(context);
      },
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is VerifyPasswordCodeErrorState) {
            Constants.showError(context, state.message);
          }

          if (state is VerifyPasswordCodeSuccessState) {
            Constants.showToast(message: state.message);
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => ResetNewPasswordScreen(
                        code: state.code,
                        mobile: widget.mobile,
                      )),
            );
          }
        },
        builder: (context, state) {
          return _buildBodyContent();
        },
      ),
    )));
  }
}
