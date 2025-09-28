import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ballaghny/features/auth/data/models/user_model.dart';
import 'package:ballaghny/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' as intl;
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/features/bottom_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:ballaghny/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:timeago/timeago.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../api/cache_helper.dart';
import '../widgets/animated_appbar.dart';
import '../widgets/dialogs/confirmation_dialog.dart';
import 'app_strings.dart';
import '../../config/locale/app_localizations.dart';
import 'app_colors.dart';

class Constants {
  static const double desktopBreakpoint = 950;
  static const double tabletBreakpoint = 600;
  static const double watchBreakpoint = 300;
  static const double bottomMarginMainScreen = 60;
  static const int fetchLimit = 10;
  static String lang = '';
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static const String testPerson =
      "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg";
  static const String testAudio =
      "https://knowingallah.com/KnowingAdmin/assets/uploads/f244f-17.mp3";
  static const String testAudio1 =
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
  static const String seahaItem =
      "https://cdn.saudigazette.com.sa/uploads/images/2024/01/09/2197274.jpeg";

  static appDocumentDirectoryPath() {
    return Platform.isAndroid
        ? "${Directory.systemTemp.path}/ballaghny"
        : "${Directory.systemTemp.path}/ballaghny";
  }

  static String getGoogleApiKey() {
    String key = ""; //AIzaSyBlIuQgcQz2BPM6XRZjeSqVTOmxrMivpE8
    if (Platform.isAndroid) {
      key = "AIzaSyCFMBbcpW3FdeuZDixu5Vi-dO517_bkelE";
    } else {
      key = "AIzaSyBlIuQgcQz2BPM6XRZjeSqVTOmxrMivpE8";
    }
    return key;
  }

  static getAppMargin(BuildContext context) {
    return context.width * 0.05;
  }

  static Future capture(GlobalKey key) async {
    RenderRepaintBoundary? boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage(pixelRatio: 3);
    final byteData = await image?.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData?.buffer.asUint8List();
    final dir = await getExternalStorageDirectory();
    final myImagePath = "${dir!.path}/myimg.png";
    File imageFile = File(myImagePath);
    if (!await imageFile.exists()) {
      imageFile.create(recursive: true);
    }
    imageFile.writeAsBytes(pngBytes ?? []);
    try {
      if (kDebugMode) {
        print("\nImage path: ${imageFile.path}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return imageFile;
  }

  static showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (BuildContext context) =>
              Platform.isIOS
                  ? ConfirmationDialog(
                    alertMsg:
                        AppLocalizations.of(
                          context,
                        )!.translate('want_to_exit')!,
                    onTapConfirm: () => exit(0),
                  )
                  : Directionality(
                    textDirection:
                        context.read<LocaleCubit>().currentLangCode == 'ar'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                    child: AlertDialog(
                      alignment: Alignment.center,
                      titleTextStyle: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontFamily: AppStrings.appFont,
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      title: Text(
                        AppLocalizations.of(
                          context,
                        )!.translate('want_to_exit')!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontFamily: AppStrings.appFont,
                        ),
                      ),
                      actions: <Widget>[
                        SizedBox(
                          width: context.width * 0.25,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: AppStrings.appFont,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () => exit(0),
                            child: Text(
                              AppLocalizations.of(context)!.translate('yes')!,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: context.width * 0.25,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: AppStrings.appFont,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              AppLocalizations.of(context)!.translate('no')!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
    );
  }

  static showOptionstoConfirm(
    BuildContext context, {
    required String msg,
    required Function() onYesTap,
    bool withCancel = true,
    Function()? onNoTap,
  }) {
    showDialog(
      context: context,
      builder:
          (BuildContext context) =>
              Platform.isIOS
                  ? ConfirmationDialog(alertMsg: msg, onTapConfirm: onYesTap)
                  : Directionality(
                    textDirection:
                        context.read<LocaleCubit>().currentLangCode == 'ar'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                    child: AlertDialog(
                      alignment: Alignment.center,
                      titleTextStyle: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontFamily: AppStrings.appFont,
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      title: Text(
                        msg,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontFamily: AppStrings.appFont,
                        ),
                      ),
                      actions: <Widget>[
                        SizedBox(
                          width: context.width * 0.25,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: AppStrings.appFont,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: onYesTap,
                            child: Text(
                              AppLocalizations.of(context)!.translate('yes')!,
                            ),
                          ),
                        ),
                        if (withCancel)
                          SizedBox(
                            width: context.width * 0.25,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: AppColors.primaryColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppStrings.appFont,
                                  fontSize: 14,
                                ),
                              ),
                              onPressed: onNoTap,
                              child: Text(
                                AppLocalizations.of(context)!.translate('no')!,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
    ).then((value) => log('opend'.toString(), name: 'opend'));
  }

  static void showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (BuildContext context) =>
              Platform.isIOS
                  ? CupertinoAlertDialog(
                    title: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: AppStrings.appFont,
                      ),
                    ),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        child: Text(
                          AppLocalizations.of(context)!.translate('ok')!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: AppStrings.appFont,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  )
                  : Directionality(
                    textDirection:
                        context.read<LocaleCubit>().currentLangCode == 'ar'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                    child: AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      alignment: Alignment.center,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      titleTextStyle: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontFamily: AppStrings.appFont,
                      ),
                      title: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontFamily: AppStrings.appFont,
                        ),
                      ),
                      actions: <Widget>[
                        SizedBox(
                          width: context.width * 0.25,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: AppStrings.appFont,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              AppLocalizations.of(context)!.translate('ok')!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
    );
  }

  static void showToast({
    required String message,
    Color? color,
    ToastGravity? gravity,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: color ?? Colors.black,
    );
  }

  static getPinPutWidget({
    required String code,
    required TextEditingController controller,
    String Function(String?)? validatorFunction,
    Function(String?)? onComplete,
  }) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          controller: controller,
          length: 4,
          validator:
              validatorFunction ??
              (value) {
                if (value!.length < code.length) {
                  return "";
                } else {
                  return null;
                }
              },
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          onCompleted: (value) => onComplete!(value),
        ),
      ),
    );
  }

  static Future<void> showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder:
          (BuildContext context) =>
              Platform.isIOS
                  ? ConfirmationDialog(
                    alertMsg:
                        AppLocalizations.of(
                          context,
                        )!.translate('want_to_logout')!,
                    onTapConfirm: () {
                      BlocProvider.of<BottomNavigationCubit>(
                        context,
                      ).upadateBottomNavIndex(0);
                      context.read<LoginCubit>().logoutLocally(
                        context: context,
                      );
                    },
                  )
                  : Directionality(
                    textDirection:
                        context.read<LocaleCubit>().currentLangCode == 'ar'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                    child: AlertDialog(
                      alignment: Alignment.center,
                      titleTextStyle: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontFamily: AppStrings.appFont,
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      title: Text(
                        AppLocalizations.of(
                          context,
                        )!.translate('want_to_logout')!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontFamily: AppStrings.appFont,
                        ),
                      ),
                      actions: <Widget>[
                        SizedBox(
                          width: context.width * 0.25,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: AppStrings.appFont,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              AppLocalizations.of(
                                context,
                              )!.translate('cancel')!,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: context.width * 0.25,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: AppStrings.appFont,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<BottomNavigationCubit>(
                                context,
                              ).upadateBottomNavIndex(0);
                              context.read<LoginCubit>().logoutLocally(
                                context: context,
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.translate('ok')!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
    );
  }

  static String? handleErrorMsg(BuildContext context, String message) {
    return message == AppStrings.noInternetConnection
        ? AppLocalizations.of(context)!.translate('no_internet_connection')
        : message == AppStrings.badRequest
        ? AppLocalizations.of(context)!.translate('bad_request')
        : message == AppStrings.unauthorized
        ? AppLocalizations.of(context)!.translate('unauthorized')
        : message == AppStrings.requestedInfoNotFound
        ? AppLocalizations.of(context)!.translate('requested_info_not_found')
        : message == AppStrings.conflictOccurred
        ? AppLocalizations.of(context)!.translate('conflict_occurred')
        : message == AppStrings.internalServerError
        ? AppLocalizations.of(context)!.translate('internal_server_error')
        : message == AppStrings.errorDuringCommunication
        ? AppLocalizations.of(context)!.translate('errorـduring_communication')
        : AppLocalizations.of(context)!.translate('something_went_wrong')!;
  }

  static Future<dynamic> bottomModelSheet(BuildContext context, Widget child) {
    return showModalBottomSheet<dynamic>(
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: child,
        );
      },
    );
  }

  static dynamic decodeJson(Response<dynamic> response) {
    var responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  //!
  static Future<void> openUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  static String fromTime({
    required BuildContext context,
    required String date,
  }) {
    // استخراج حقل التاريخ
    String dateString = date;

    // تحويل النص إلى كائن DateTime
    DateTime dateTime = DateTime.parse(dateString);

    // تسجيل اللغة العربية
    timeago.setLocaleMessages('ar', ArMessages());

    // حساب الفرق الزمني باللغة العربية
    String timeAgo = timeago.format(dateTime, locale: 'ar');

    return timeAgo;
  }

  static Widget getRichText(
    BuildContext context, {
    bool? haveTranslate = false,
    bool? haveHighlightTranslate = false,
    String? textBody,
    String? highlightText,
    Color? highLightcolor = Colors.red,
    Color? textbodyColor = Colors.black,
    // text body
    double textBodySize = 15.6,
    FontWeight textBodyWeight = FontWeight.normal,
    //highlight
    double highlightTextSize = 15.6,
    FontWeight highlightWeight = FontWeight.normal,
    //condetion
    bool haveThreeTextSpan = false,
    String? textBody2,
  }) {
    var translator = AppLocalizations.of(context)!;

    List<TextSpan> textSpans = <TextSpan>[
      TextSpan(
        text:
            haveTranslate == true ? translator.translate(textBody!) : textBody,
        style: TextStyle(
          fontSize: textBodySize,
          color: textbodyColor,
          fontWeight: textBodyWeight,
        ),
      ),
      TextSpan(
        text:
            haveHighlightTranslate == true
                ? translator.translate(highlightText!)
                : highlightText,
        style: TextStyle(
          fontSize: highlightTextSize,
          color: highLightcolor,
          fontWeight: highlightWeight,
        ),
      ),
      haveThreeTextSpan
          ? TextSpan(
            text:
                haveHighlightTranslate == true
                    ? translator.translate(textBody2!)
                    : textBody2,
            style: TextStyle(
              fontSize: textBodySize,
              color: textbodyColor,
              fontWeight: textBodyWeight,
            ),
          )
          : const TextSpan(),
    ];
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style:
            haveThreeTextSpan
                ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )
                : TextStyle(color: AppColors.primaryColor, fontSize: 18),
        children: textSpans,
      ),
    );
  }

  static dynamic decodeStringJson(Response<String> response) {
    var responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  static UserModel getUserProfile() {
    String? savedUser = CacheHelper.getData(key: AppStrings.userProfileData);
    final jsonUser = jsonDecode(savedUser ?? '');
    return UserModel.fromJson(jsonUser);
  }

  static dynamic decodeJsonDynamic(Response response) {
    var responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  static PreferredSize getLightAppBar(
    BuildContext context, {
    required String title,
    bool moreHeight = true,
    Color? backgroundColor,
    Color? titleColor,
    Color? leadingColor,
    bool showAnimatedAppBar = true,
    Function()? onTap,
    final double? height,
    final List<Widget>? actions,
    final bool haveLeading = true,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(moreHeight ? 70 : height ?? 50),
      child:
          (title.length >= 33)
              ? AnimatedAppBar(
                animatedText: title,
                leadingColor: leadingColor ?? AppColors.primaryColor,
                onLeadingTap: onTap,
                haveLeading: haveLeading,
              )
              : Padding(
                padding: const EdgeInsets.only(top: 5),
                child: AppBar(
                  toolbarHeight: moreHeight ? 70 : height ?? 30,
                  backgroundColor: backgroundColor ?? Colors.white,
                  elevation: 0,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  leading:
                      haveLeading && Platform.isIOS
                          ? IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: leadingColor ?? AppColors.primaryColor,
                            ),
                            onPressed: onTap ?? () => Navigator.pop(context),
                          )
                          : haveLeading && Platform.isAndroid
                          ? IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: leadingColor ?? AppColors.primaryColor,
                            ),
                            onPressed: onTap ?? () => Navigator.pop(context),
                          )
                          : null,
                  title: FittedBox(
                    child: Text(
                      title,
                      style: Theme.of(
                        context,
                      ).appBarTheme.titleTextStyle!.copyWith(
                        color: titleColor ?? AppColors.primaryColor,
                      ),
                    ),
                  ),
                  centerTitle: true,
                  titleTextStyle: TextStyle(
                    fontSize: context.width * 0.06,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  actions: actions,
                  // systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
                ),
              ),
    );
  }

  static PreferredSize getDarkAppBar(
    BuildContext context, {
    required String title,
    bool moreHeight = true,
    Color? backgroundColor,
    Color? titleColor,
    Color? leadingColor,
    Function()? onTap,
    final double? height,
    final List<Widget>? actions,
    final bool haveLeading = true,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(moreHeight ? 70 : height ?? 50),
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: AppBar(
          toolbarHeight: moreHeight ? 70 : height ?? 30,
          backgroundColor: backgroundColor ?? Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor,
            statusBarIconBrightness: Brightness.light,
          ),
          leading:
              haveLeading && Platform.isIOS
                  ? IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: leadingColor ?? AppColors.primaryColor,
                    ),
                    onPressed: onTap ?? () => Navigator.pop(context),
                  )
                  : haveLeading && Platform.isAndroid
                  ? IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: leadingColor ?? AppColors.primaryColor,
                    ),
                    onPressed: onTap ?? () => Navigator.pop(context),
                  )
                  : null,
          title: Text(
            title,
            style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
              color: titleColor ?? AppColors.primaryColor,
            ),
          ),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: context.width * 0.06,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
          actions: actions,
          // systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        ),
      ),
    );
  }

  static String formatDate(
    String rawDate, {
    bool withOutDayNameAnYear = false,
    String separator = '/',
  }) {
    initializeDateFormatting("ar_SA", '');
    var rawDateSwgments = rawDate.split(separator).toList();
    var dateObject = DateTime(
      int.parse(rawDateSwgments[2]),
      int.parse(rawDateSwgments[1]),
      int.parse(rawDateSwgments[0]),
    );
    var formatter =
        withOutDayNameAnYear
            ? intl.DateFormat.MMMMd('ar_SA')
            : intl.DateFormat.MMMMEEEEd('ar_SA');
    //     var formatter = DateFormat.yMMMd('ar_SA');
    debugPrint(formatter.locale);
    String formatted = formatter.format(dateObject);

    formatted = formatted.replaceAll('، ', '\n');
    return formatted;
  }
}
