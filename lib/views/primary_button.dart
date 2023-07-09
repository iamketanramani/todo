import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/resource/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final String? prefix;

  final double? height;
  final double? width;
  final double? textSize;
  final double? borderRadius;

  final Color? textColor;
  final Color? backGroundColor;

  final FontWeight? fontWeight;

  final VoidCallback? onPressed;

  const PrimaryButton({
    Key? key,
    this.text = '',
    this.prefix = '',
    this.height,
    this.width,
    this.textSize,
    this.borderRadius,
    this.textColor,
    this.backGroundColor,
    this.fontWeight,
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
              return backGroundColor ?? AppColors.primaryColor;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
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
              return backGroundColor ?? AppColors.primaryColor;
            },
          ),
          visualDensity:
              const VisualDensity(horizontal: VisualDensity.minimumDensity),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefix!.isNotEmpty)
              SvgPicture.asset(
                prefix!,
                // colorFilter:
                //     const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                width: 14,
                height: 14,
              ),
            if (prefix!.isNotEmpty) const SizedBox(width: 5),
            Flexible(
              child: Text(
                text!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor ?? AppColors.white,
                  fontSize: textSize ?? 15,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  fontFamily: 'AppFont',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
