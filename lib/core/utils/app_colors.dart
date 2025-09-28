import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/hex_color.dart';

class AppColors {
  static Color primaryColor = HexColor("#2990D5");
  static Color secondryColor = HexColor("#ED6A24");
  static Color borderColor = HexColor("##ECF0F3");
  static Color hintColor = HexColor('8E8E93');
  static Color hintAccentColor = Colors.black54;
  // static Color notificationAlert = Colors.blue;
  static Color iconBlackColor = Colors.black;
  static Color shadowColor = Colors.grey.shade400;
  static Color paymentTypeBackgroundColor = HexColor('#B9B9B9');
  static Color outlineBorder = HexColor('#E9E6E7');
  static Color chattingBgColor = HexColor('#F4F6F7');
  static Color greyColor = Colors.grey;
  static Color bgImageViewColor = HexColor('#05332B').withOpacity(0.67);
  static Color dropMenuTitleColor = HexColor('#B7BFBD');
  static Color activeColor = HexColor('#2CDA86');
  static Color notActiveColor = HexColor('#E82552');
  static Color permissionColor = HexColor('#EBC73E');
  static Color instructorNotActiveColor = HexColor('#31A2DC');
  static var linearGradient = LinearGradient(
    colors: [
      HexColor('2896E0').withOpacity(0.15),
      HexColor('FFFFFF').withOpacity(0.1),
      HexColor('F9E2D5').withOpacity(0.5),
    ],
    begin: Alignment.topLeft, // التدرج يبدأ من الأعلى
    end: Alignment.bottomRight, // وينتهي في الأسفل
  );

  static var appBarLinearGradient = LinearGradient(
    colors: [
      HexColor('2896E0').withOpacity(0.15),
      HexColor('F9E2D5').withOpacity(0.2),
    ],
    begin: Alignment.topLeft, // التدرج يبدأ من الأعلى
    end: Alignment.bottomRight, // وينتهي في الأسفل
  );

// * ==== Payments Colors ====

// lightcolors
  static Color lightBlueColor = HexColor('#EBEDFD');
  static Color lightRoseColor = HexColor('#FFE7F2');
  static Color lightGreenColor = HexColor('#E9FDFB');

// solidcolors
  static Color solidBlueColor = HexColor('#4050F5');
  static Color solidRoseColor = HexColor('#FF68AF');
  static Color solidGreenColor = HexColor('#3ADDCD');

// Acception Colors
  static Color acceptedColor = HexColor('#54C68F');
  static Color delayedColor = HexColor('#EBC73E');
  static Color rejectedColor = HexColor('#CC4D41');

//
  static const colorAccent = Color(0xFF03DAC5);
  static Color rose = const Color(0xFFFF68AF);
  static Color blue2 = const Color(0xFF4050F5);

  static Color greyBorder = const Color(0xFFDDE6E3);
  static Color lightGreen = const Color(0xFFE8F7F0);
  static Color greyText = const Color(0xFF4A4A4A);

//manaheg
  static Color freeBackgroundColor = HexColor('#EAF5FA');
  static Color paidBackgroundColor = HexColor('#FEF0F7');
  static Color freeTextColor = HexColor('#00ABFF');
  static Color paidTextColor = HexColor('#FF68AF');
  static Color yellow = HexColor('#FFD349');
}
