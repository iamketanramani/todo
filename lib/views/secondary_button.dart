import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/resource/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final String? text;
  final String? prefix;
  final Color? prefixColor;
  final String? suffix;

  final double? height;
  final double? width;
  final double? textSize;
  final double? borderRadius;

  final Color? textColor;
  final Color? backGroundColor;
  final Color? buttonBorderColor;

  final FontWeight? fontWeight;

  final MainAxisAlignment? mainAxisAlignment;

  final VoidCallback? onPressed;

  const SecondaryButton({
    Key? key,
    this.text = '',
    this.prefix = '',
    this.prefixColor,
    this.suffix = '',
    this.height,
    this.width,
    this.textSize,
    this.borderRadius,
    this.textColor,
    this.backGroundColor,
    this.buttonBorderColor,
    this.fontWeight,
    this.mainAxisAlignment,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              /*if (states.contains(MaterialState.disabled)) {
                return greyColor;
              }*/
              return backGroundColor ?? AppColors.primaryColorLight;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: buttonBorderColor ?? AppColors.primaryColorLight,
              ),
              borderRadius: (borderRadius != null)
                  ? BorderRadius.circular(borderRadius!)
                  : BorderRadius.circular(10),
            ),
          ),
          elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return 0;
              }
              return 0;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              /*if (states.contains(MaterialState.disabled)) {
                return greyColor;
              }*/
              return backGroundColor ?? AppColors.textColor;
            },
          ),
          visualDensity:
              const VisualDensity(horizontal: VisualDensity.minimumDensity),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisSize: mainAxisAlignment == MainAxisAlignment.center
                    ? MainAxisSize.min
                    : MainAxisSize.max,
                mainAxisAlignment:
                    mainAxisAlignment ?? MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      text!,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor ?? AppColors.primaryColor,
                        fontSize: textSize ?? 15,
                        fontWeight: fontWeight ?? FontWeight.w600,
                        fontFamily: 'AppFont',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (suffix!.isNotEmpty)
              SvgPicture.asset(
                suffix!,
                // colorFilter:
                //     const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                width: 20,
                height: 20,
              ),
          ],
        ),
      ),
    );
  }
}
