import 'package:flutter/material.dart';
import 'package:todo/resource/app_colors.dart';

class AppStyles {
  static const fontFamily = "AppFont";

  static InputDecoration etDecoration({
    String hintText = '',
    bool havePrefix = false,
    bool havePostfix = false,
  }) =>
      InputDecoration(
        counterText: '',
        contentPadding: EdgeInsets.only(
          left: havePrefix ? 55 : 25,
          right: havePostfix ? 55 : 25,
          top: 15,
          bottom: 15,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.hintColor, fontSize: 16),
        errorStyle: const TextStyle(color: Colors.red),
        errorMaxLines: 2,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: AppColors.borderColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: AppColors.borderColor, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: AppColors.borderColor, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: AppColors.borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: AppColors.borderColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: AppColors.borderColor, width: 1),
        ),
      );

  static TextStyle etTextStyle = TextStyle(
    color: AppColors.textColor,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static Dialog customDialog({
    required Widget? child,
    double borderRadius = 10,
    Color? backgroundColor,
    EdgeInsets insetPadding =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  }) {
    return Dialog(
      backgroundColor: backgroundColor ?? AppColors.white,
      insetPadding: insetPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
