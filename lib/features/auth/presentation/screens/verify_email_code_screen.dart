import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/features/auth/presentation/cubits/verify/verify_cubit.dart';
import 'package:ballaghny/features/home/presentation/screens/home_body.dart';

import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/default_text_form_field/default_text_form_field.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/animation/fade_animation.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_text_form_field/validation_mixin.dart';
import '../../../../core/widgets/screen_container.dart';
import '../../../../core/widgets/text_form_field_header.dart';

class VerifyEmailCodeScreen extends StatefulWidget {
  final String email;
  final String type;

  const VerifyEmailCodeScreen(
      {super.key, required this.email, required this.type});

  @override
  State<VerifyEmailCodeScreen> createState() => _VerifyEmailCodeScreenState();
}

class _VerifyEmailCodeScreenState extends State<VerifyEmailCodeScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  _sendCode() {
    // BlocProvider.of<VerifyCubit>(context).sendCode(
    //   email: widget.email,
    //   type: widget.type,
    // );
  }

  @override
  void initState() {
    super.initState();
    _sendCode();
  }

  Widget _buildBodyContent() {
    return Container(
      height: context.height,
      padding: EdgeInsets.all(24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(24), topLeft: Radius.circular(24)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.translate('verify_code')!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(color: HexColor('FFFBE6')),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: HexColor('FF9500'),
                        ),
                        const SizedBox(
                          width: 8,
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FadeAnimation(1.3,
                      child: TextFormFieldHeader(
                        title: AppLocalizations.of(context)!.translate('code')!,
                      )),
                  FadeAnimation(1.6,
                      child: DefaultTextFormField(
                        hintTxt:
                            AppLocalizations.of(context)!.translate('code')!,
                        // inputData: TextInputType.emailAddress,
                        controller: _codeController,
                        suffixIcon: Icon(
                          Icons.pin,
                          color: Colors.grey,
                        ),
                        validationFunction:
                            validateCodeInput, // validateEmailInput
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<VerifyCubit, VerifyState>(
                      builder: (context, state) {
                    return FadeAnimation(2.8,
                        child: Container(
                            margin: const EdgeInsets.only(top: 30, bottom: 16),
                            child: DefaultButton(
                                margin: 0,
                                isLoading: state is VerifyLoadingState,
                                btnLbl: AppLocalizations.of(context)!
                                    .translate('send')!,
                                endIcon: Icon(Icons.arrow_forward),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (widget.type == 'verify') {
                                      BlocProvider.of<VerifyCubit>(context)
                                          .verifyCode(_codeController.text);
                                    }
                                  }
                                })));
                  }),
                ],
              ))),
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
      child: BlocConsumer<VerifyCubit, VerifyState>(
        listener: (context, state) {
          if (state is VerifyEmailCodeErrorState) {
            Constants.showError(context, state.message);
          }
          if (state is SendCodeSuccessState) {
            Constants.showToast(message: state.message);
          }
          if (state is VerifyEmailCodeSuccessState) {
            Constants.showToast(message: state.message);
            Navigator.of(context).pushReplacementNamed(Routes.homeScreen,
                arguments: {'widget': HomeBodyScreen()});
          }
        },
        builder: (context, state) {
          if (state is SendCodeLoadingState) {
            return const LoadingIndicator();
          }
          return _buildBodyContent();
        },
      ),
    )));
  }
}
