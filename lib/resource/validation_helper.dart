import 'package:flutter/services.dart';
import 'package:todo/resource/app_strings.dart';

class ValidationHelper {
  static List<TextInputFormatter> allowCharactersOnly = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(AppStrings.regexCharactersOnly))
  ];

  static List<TextInputFormatter> allowCharactersWithSpace =
      <TextInputFormatter>[
    FilteringTextInputFormatter.allow(
        RegExp(AppStrings.regexCharactersWithSpace))
  ];

  static List<TextInputFormatter> allowDigitsOnly = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly
  ];

  static List<TextInputFormatter> allowDecimalDigitsOnly = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
  ];

  static List<TextInputFormatter> allow3DecimalDigitsOnly =
      <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,5}(\.\d{0,3})?%?'))
  ];

  /* static dynamic isValidEmail(String email, {String? message}) {
    if (email.trim().isEmpty) {
      return message ?? AppStrings.strEnterEmailId;
    } else if (!RegExp(AppStrings.regexEmail).hasMatch(email.trim())) {
      return AppStrings.strEnterValidEmail;
    } else {
      return null;
    }
  }

  static dynamic isValidContactNo(String contactNo, {String? message}) {
    if (contactNo.trim().isEmpty) {
      return message ?? AppStrings.strEnterMobileNo;
    } else if (contactNo.trim().length < AppStrings.contactNoMinLength) {
      return AppStrings.strContactNoInvalid;
    } else {
      return null;
    }
  } */

  static bool isNumericString(String? s) {
    if (s == null) {
      return false;
    }

    return double.tryParse(s) != null;
  }

  static bool isValidString(String? strToValidate) {
    bool result = false;

    if (strToValidate != null &&
        strToValidate.toLowerCase().trim() != 'null' &&
        strToValidate.trim().isNotEmpty) {
      result = true;
    }

    return result;
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
