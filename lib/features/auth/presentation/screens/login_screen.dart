import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ballaghny/core/utils/app_strings.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/features/home/presentation/screens/home_body.dart';
import 'package:ballaghny/features/notifications/services/signalling.service.dart';

import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/default_text_form_field/default_text_form_field.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/animation/fade_animation.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_text_form_field/validation_mixin.dart';
import '../../../../core/widgets/screen_container.dart';
import '../cubits/login/login_cubit.dart';
import '../../../../core/widgets/text_form_field_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _credentialsIsRemembered = false;
  //TODO: will add social login later
  late GoogleSignIn _googleSignIn;
  late GoogleSignInAccount _currentUser;

  //TODO: will add social login later
  Future<dynamic> _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _login("google", googleAuth.accessToken!);
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      debugPrint('Google Sign In Error: $e');
    }
  }

  Future<void> _login(String provider, String token) async {
    await context.read<LoginCubit>().socialAuth(
      provider: provider,
      socialToken: token,
    );
  }

  AutovalidateMode autovalidateMode(LoginState state) =>
      state is LoginValidatation
          ? (state.isValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled)
          : AutovalidateMode.disabled;

  Widget _buildBodyContent(LoginState state) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: context.height,
      decoration: BoxDecoration(gradient: AppColors.linearGradient),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: autovalidateMode(state),
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(child: Image.asset(AppAssets.logo, width: 100)),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  key: const Key('login_title'),
                  AppLocalizations.of(context)!.translate('login')!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.translate('login_title')!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 16),
              FadeAnimation(
                1.3,
                child: TextFormFieldHeader(
                  title: AppLocalizations.of(context)!.translate('email')!,
                ),
              ),
              FadeAnimation(
                1.6,
                child: DefaultTextFormField(
                  key: const Key('email_field'),
                  autovalidateMode: autovalidateMode(state),
                  hintTxt: AppLocalizations.of(context)!.translate('email')!,
                  inputData: TextInputType.emailAddress,
                  controller: _emailController,
                  suffixIcon: Icon(Icons.email, color: Colors.grey),
                  validationFunction: validateEmail,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
              ),
              FadeAnimation(
                1.9,
                child: TextFormFieldHeader(
                  title: AppLocalizations.of(context)!.translate('password')!,
                ),
              ),
              FadeAnimation(
                2.2,
                child: DefaultTextFormField(
                  key: const Key('password_field'),
                  autovalidateMode: autovalidateMode(state),
                  hintTxt: AppLocalizations.of(context)!.translate('password')!,
                  isPassword: true,
                  inputData: TextInputType.visiblePassword,
                  controller: _passwordController,
                  validationFunction: validatePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                ),
              ),
              FadeAnimation(
                2.5,
                child: Container(
                  margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Row(
                    children: [
                      StatefulBuilder(
                        builder: ((context, setState) {
                          return InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              setState(() {
                                _credentialsIsRemembered =
                                    !_credentialsIsRemembered;
                              });
                            },
                            child: Row(
                              children: [
                                _credentialsIsRemembered
                                    ? Container(
                                      height: 24,
                                      width: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: AppColors.hintColor,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                    : Container(
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: AppColors.hintColor,
                                        ),
                                      ),
                                    ),
                                const SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.translate('remember_me')!,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap:
                            () => Navigator.pushNamed(
                              context,
                              Routes.forgotPasswordRoute,
                            ),
                        child: Text(
                          AppLocalizations.of(
                            context,
                          )!.translate('forgot_password')!,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FadeAnimation(
                2.8,
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 16),
                  child:
                      !context.watch<LoginCubit>().isloading
                          ? DefaultButton(
                            key: const Key('login_button'),
                            isLoading: context.watch<LoginCubit>().isloading,
                            btnLbl:
                                AppLocalizations.of(
                                  context,
                                )!.translate('sign_in')!,
                            onPressed: () {
                              // Navigator.pushNamed(
                              //     context, Routes.homeScreen,
                              //     arguments: {'widget': HomeBodyScreen()});

                              loginWithFirebaseToken();
                            },
                          )
                          : const LoadingIndicator(),
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
              //           child: const Divider(
              //             thickness: 1,
              //             color: Colors.grey,
              //             height: 30,
              //           ),
              //         ),
              //         const SizedBox(width: 8),
              //         // Text(
              //         //   AppLocalizations.of(
              //         //     context,
              //         //   )!.translate('or_login_with')!,
              //         //   style: Theme.of(context).textTheme.displayMedium,
              //         // ),
              //         // const SizedBox(width: 8),
              //         // SizedBox(
              //         //   width: context.width * 0.2,
              //         //   child: const Divider(
              //         //     thickness: 1,
              //         //     color: Colors.grey,
              //         //     height: 30,
              //         //   ),
              //         // ),
              //       ],
              //     ),
              //   ),
              // ),
              //TODOwill Add social login later
              // FadeAnimation(
              //   3.1,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       InkWell(
              //         onTap: () => _loginWithGoogle(),
              //         child: Image.asset(AppAssets.googleIcon),
              //       ),
              //       const SizedBox(
              //         width: 16,
              //       ),
              //       InkWell(
              //         onTap: () => _loginWithGoogle(),
              //         child: Image.asset(AppAssets.xIcon),
              //       ),
              //       const SizedBox(
              //         width: 16,
              //       ),
              //       InkWell(
              //         onTap: () => _loginWithGoogle(),
              //         child: Image.asset(AppAssets.facebookIcon),
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(height: context.height * 0.02),
              FadeAnimation(
                3.1,
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
                              text:
                                  AppLocalizations.of(
                                    context,
                                  )!.translate("don't_have_account?")!,
                              style: Theme.of(context).textTheme.displayMedium,
                              children: <InlineSpan>[
                                const TextSpan(text: '  '),
                                TextSpan(
                                  text:
                                      AppLocalizations.of(
                                        context,
                                      )!.translate("register_now")!,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(color: AppColors.primaryColor),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap =
                                            () => Navigator.pushNamed(
                                              context,
                                              Routes.registerRoute,
                                            ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.homeScreen,
                            arguments: {'widget': HomeBodyScreen()},
                          );
                        },
                        child: Text(
                          AppLocalizations.of(
                            context,
                          )!.translate('contiue_as_visitor')!,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.greyColor,
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
      ),
    );
  }

  Future<void> loginWithFirebaseToken() async {
    if (_formKey.currentState!.validate()) {
      String? token = await _firebaseMessaging.getToken();
      await context.read<LoginCubit>().login(
        formKey: _formKey,
        email: _emailController.text,
        password: _passwordController.text,
        deviceType: Platform.isIOS ? 'ios' : 'android',
        firebaseToken: token ?? '',
        credentialsIsSaved: _credentialsIsRemembered,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      key: const Key('login_screen'),
      child: Scaffold(
        // ignore: deprecated_member_use
        body: WillPopScope(
          onWillPop: () async {
            return Constants.showExitDialog(context);
          },
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is Authenticated) {
                _firebaseMessaging.getToken().then((token) async {
                  if (token != null) {
                    log(token.toString(), name: 'mobiletoken');
                    await context.read<LoginCubit>().sendToken(
                      token: token,
                      deviceType:
                          Platform.isAndroid
                              ? AppStrings.android
                              : AppStrings.ios,
                    );
                  }
                });
                // Navigator.pushNamed(context, Routes.homeScreen,
                //     arguments: {'widget': HomeBodyScreen()});
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.homeScreen,
                  arguments: {'widget': HomeBodyScreen()},
                  (route) => false,
                );
              } else if (state is UnAuthenticated) {
                Constants.showError(context, state.message);
              }
            },
            builder: (context, state) {
              return SafeArea(child: _buildBodyContent(state));
            },
          ),
        ),
      ),
    );
  }
}
