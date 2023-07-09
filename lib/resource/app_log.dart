// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer' as developer;
import 'dart:io';

import 'package:todo/resource/app_helper.dart';

/// Component: Log (in Debug Console)
/// Author : Ketan Ramani
/// Use : To Show logs in different color in Debug Console

/// Usage:
/// 1. AppLog.d(message);
/// 2. AppLog.d(message,tag: 'Your custom tag');

/// Reset:   \x1B[0m
/// Black:   \x1B[30m
/// White:   \x1B[37m
/// Red:     \x1B[31m
/// Green:   \x1B[32m
/// Yellow:  \x1B[33m
/// Blue:    \x1B[34m
/// Cyan:    \x1B[36m

class AppLog {
  static const String _defaultTagPrefix = "Ketan";

  ///Print info logs
  static i(String message, {String tag = _defaultTagPrefix}) {
    // Blue Color
    String log = "INFO ⓘ |" + tag + ": " + '\x1B[34m$message\x1B[0m';
    developer.log(log);
    if (Platform.isIOS) AppHelper.showLog(message);
  }

  ///Print debug logs
  static d(String message, {String tag = _defaultTagPrefix}) {
    // Green Color
    String log = "DEBUG | " + tag + ": " + '\x1B[32m$message\x1B[0m';
    developer.log(log);
    if (Platform.isIOS) AppHelper.showLog(message);
  }

  ///Print warning logs
  static w(String message, {String tag = _defaultTagPrefix}) {
    //Yellow Color
    String log = "WARN⚠️ | " + tag + ": " + '\x1B[33m$message\x1B[0m';
    developer.log(log);
    if (Platform.isIOS) AppHelper.showLog(message);
  }

  ///Print error logs
  static e(String message, {String tag = _defaultTagPrefix}) {
    //Red Color
    String log = "ERROR⚠️ |️ " + tag + ": " + '\x1B[31m$message\x1B[0m';
    developer.log(log);
    if (Platform.isIOS) AppHelper.showLog(message);
  }

  ///Print failure logs (WTF = What a Terrible Failure)
  static wtf(String message, {String tag = _defaultTagPrefix}) {
    //Cyan Color
    String log = "WTF¯\\_(ツ)_/¯|" + tag + ": " + '\x1B[36m$message\x1B[0m';
    developer.log(log);
    if (Platform.isIOS) AppHelper.showLog(message);
  }

  ///Print debug log
  /* static debugPrint(var message, {String tag = _defaultTagPrefix}) {
    debugPrint(tag + '' + message);
  } */

  ///Print entire debug log
  /* static debugPrintLarge(var message) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(message).forEach((match) => debugPrint(match.group(0)));
  } */
}
