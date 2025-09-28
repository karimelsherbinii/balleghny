import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/hex_color.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: AppStrings.appFont,
    primaryColor: AppColors.primaryColor,
    hintColor: AppColors.hintColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,

    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
          fontSize: 19,
          fontFamily: AppStrings.appFont,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor),
      toolbarTextStyle: TextStyle(
          fontSize: 14,
          fontFamily: AppStrings.appFont,
          fontWeight: FontWeight.bold,
          color: AppColors.hintColor),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          elevation: 0,
          textStyle: const TextStyle(
              fontFamily: AppStrings.appFont,
              fontWeight: FontWeight.w700,
              fontSize: 14)),
    ),
    // textButtonTheme: TextButtonThemeData(
    //     style: TextButton.styleFrom(
    //   backgroundColor: AppColors.primaryColor,
    // )
    // )
    // ,
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),

// style of about app
      headlineSmall:
          TextStyle(color: HexColor('#40625C'), fontSize: 14, height: 1.5),

      // style of text ( create account)
      displayLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),

      // header of text form field
      displayMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.hintColor),

      // pop up items
      displaySmall: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),

      //  style of title like enter email
      bodyLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),

      //  style of text (create account through social medial)
      bodyMedium: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),

      //  style of description text in auth screens
      bodySmall: const TextStyle(
          height: 1.5,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF40625C)),

      // style of button
      labelLarge: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      labelMedium: const TextStyle(
          height: 1.3,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xff05332B)),

      // style of text form field
      labelSmall: const TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      titleSmall: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: AppStrings.cairoFontFamily,
          color: Colors.black),
      titleMedium: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: AppStrings.cairoFontFamily,
          color: Colors.white),
      titleLarge: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: AppStrings.appFont,
          color: Colors.black),
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColor),
      hintStyle: TextStyle(
          color: AppColors.hintColor,
          fontSize: 16,
          fontWeight: FontWeight.w400),
      errorStyle: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.w400, color: Colors.red),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: AppColors.hintColor)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: AppColors.hintColor)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(32),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(32),
      ),
    ),
  );
}
