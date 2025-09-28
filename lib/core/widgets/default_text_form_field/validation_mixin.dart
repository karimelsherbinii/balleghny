import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import '../../../config/locale/app_localizations.dart';
import 'package:intl/intl.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  String? _password, _newPassword;

  String? validateEmail(String? email) {
    if (email!.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate('email_validation');
    } else if ((!isEmail(email))) {
      return AppLocalizations.of(context)!.translate('email_not_valid');
    }
    return null;
  }

  String? validateUserName(String? userName) {
    if (userName!.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate('user_name_validation');
    }
    return null;
  }

  String? validatePhoneNO(String? phoneNo, String countryCode) {
    var translator = AppLocalizations.of(context)!;
    if (phoneNo!.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate('phone_no_validation');
    }
    //remove +
    phoneNo = phoneNo.replaceAll('+', '');
    // countryCode = countryCode.replaceAll('+', '');// i remove it bec i downt need it for now

    if (phoneNo.startsWith(countryCode)) {
      log('value: $phoneNo');

      return translator
          .translate('phone_number_should_not_include_country_code');
    }
    if (phoneNo.startsWith('0')) {
      return translator.translate('phone_number_no_zero');
    }
    if (phoneNo.length > 15) {
      //should be not more than 15 digits
      return translator
          .translate('phone_number_should_be_not_more_than_15_digits');
    }

    return null;
  }

  String? validateFirstName(String? firstName) {
    if (firstName!.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate('first_name_validation');
    } else if (firstName.length < 3) {
      return AppLocalizations.of(context)!
          .translate('length_must_be_3_at_least');
    }
    return null;
  }

  String? validateLastName(String? lastName) {
    if (lastName!.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate('last_name_validation');
    } else if (lastName.length < 3) {
      return AppLocalizations.of(context)!
          .translate('length_must_be_3_at_least');
    }
    return null;
  }

  String? validatePassword(String? password) {
    _password = password;
    if (password!.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate('password_validation');
    }
    return null;
  }

  String? validateNewPassword(String? newPassword) {
    _newPassword = newPassword;
    if (newPassword!.trim().isEmpty) {
      return AppLocalizations.of(context)!.translate('new_password_validation');
    }
    return null;
  }

  String? validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword!.trim().isEmpty) {
      return AppLocalizations.of(context)!
          .translate('confirm_password_validation')!;
    } else if (_password != confirmPassword) {
      return AppLocalizations.of(context)!.translate('password_not_identical');
    }
    return null;
  }

  String? validateConfirmNewPassword(String? confirmNewPassword) {
    if (confirmNewPassword!.trim().isEmpty) {
      return AppLocalizations.of(context)!
          .translate('confirm_new_password_validation')!;
    } else if (_newPassword != confirmNewPassword) {
      return AppLocalizations.of(context)!.translate('password_not_identical');
    }
    return null;
  }

  String? validateGender(dynamic gender) {
    if (gender == null) {
      return AppLocalizations.of(context)!.translate('gender_validation');
    }
    return null;
  }

  String? validateCountry(dynamic country) {
    if (country == null) {
      return AppLocalizations.of(context)!.translate('gender_validation');
    }
    return null;
  }

  String? validateNationality(dynamic nationality) {
    if (nationality == null) {
      return AppLocalizations.of(context)!.translate('nationality_validation');
    }
    return null;
  }

  // String? validateLanguage(dynamic language) {
  //   if (language == null) {
  //     return AppLocalizations.of(context)!.translate('language_validation');
  //   }
  // }

  String? validateAbsentRequestDetails(String? value) {
    if (value == '') {
      return AppLocalizations.of(context)!
          .translate('detials_absent_validation');
    } else if (value!.length < 3) {
      return AppLocalizations.of(context)!
          .translate('details_absent_length_validation');
    } else {
      return null;
    }
  }

  String? validateAbsentRequestTitle(String? value) {
    if (value == '') {
      return AppLocalizations.of(context)!.translate('title_absent_validation');
    } else if (value!.length < 3) {
      return AppLocalizations.of(context)!
          .translate('title_absent_length_validation');
    } else {
      return null;
    }
  }

  String? validateAbsentRequestFromDate(String? value) {
    final date = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    if (value == '') {
      return AppLocalizations.of(context)!.translate('date_absent_validation');
    } else if (DateFormat('dd/MM/yyyy')
        .parse(value!)
        .isBefore(DateFormat('dd/MM/yyyy').parse(formattedDate))) {
      return AppLocalizations.of(context)!.translate('invalid_from_date');
    }
    return null;
  }

  String? validateIsParent(dynamic value) {
    if (value == null) {
      return AppLocalizations.of(context)!.translate('is_parent_validation');
    }
    return null;
  }

  //validateCodeInput
  String? validateCodeInput(String? value) {
    if (value == '') {
      return AppLocalizations.of(context)!.translate('code_input_validation');
    }
    return null;
  }
}
