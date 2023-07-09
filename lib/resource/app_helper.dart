import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:todo/resource/app_log.dart';

class AppHelper {
  static void showLog(String message) {
    if (kDebugMode) {
      debugPrint(message);
    } else if (kReleaseMode) {
      // ignore: avoid_print
      print(message);
    }
  }

  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (Platform.isIOS) {
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus!.unfocus();
      }
    } else if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static String generateRandomString(int len) {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  static Color getColorFromHex(String hexColor) {
    return Color(
      int.parse((hexColor).replaceAll('#', '0xff')),
    );
  }

  static String dateTimeToString(DateTime dateTime,
      {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(dateTime);
  }

  static DateTime stringToDateTime(String dateTime,
      {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.parse(dateTime);
  }

  static String changeDateForat(
    String dateTime, {
    String fromFormat = 'yyyy-MM-dd HH:mm:ss',
    String toformat = 'yyyy-MM-dd HH:mm:ss',
  }) {
    DateFormat fromDate = DateFormat(fromFormat);
    DateTime dt = fromDate.parse(dateTime);
    DateFormat toDate = DateFormat(toformat);
    String dtt = toDate.format(dt);

    return dtt;
  }

  static String getDecimalTwoNumber({double? no}) {
    String result = no.toString();
    int decimalIndex = result.indexOf('.');
    if (decimalIndex != -1 && result.length > decimalIndex + 2 + 1) {
      result = result.substring(0, decimalIndex + 2 + 1);
    }
    return result;
  }

  static String getNumber(double data, {int precision = 3}) {
    num mod = pow(10.0, precision);
    return ((data * mod).round().toDouble() / mod).toString();

    /* return double.parse(
        '$input'.substring(0, '$input'.indexOf('.') + precision + 1)); */
  }

  static String capitalizeFirst(String text) {
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }

  static bool isValidString(String text) {
    bool isValid = false;
    if (text.isNotEmpty && text.toLowerCase().trim() != 'null') {
      isValid = true;
    }
    return isValid;
  }

  static void popScreen(BuildContext context, int popScreen) {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= popScreen);
  }

  static DateStatus? compareDate({String? date1, String? date2}) {
    DateStatus status = DateStatus.none;

    DateTime dt1 = DateTime.parse(date1!);
    DateTime dt2 = DateTime.parse(date2!);

    if (dt1.compareTo(dt2) == 0) {
      status = DateStatus.equal;
    }

    if (dt1.compareTo(dt2) < 0) {
      status = DateStatus.before;
    }

    if (dt1.compareTo(dt2) > 0) {
      status = DateStatus.after;
    }

    AppLog.d('Ketan:Date_Comparision: $status');
    return status;
  }
}

enum DateStatus { none, before, after, equal }
