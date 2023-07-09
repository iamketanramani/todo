import 'package:flutter/material.dart';
import 'package:todo/resource/app_colors.dart';

class BottomShadowContainer extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final bool? hideShadow;

  const BottomShadowContainer({
    Key? key,
    this.padding,
    this.child,
    this.hideShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: hideShadow!
            ? []
            : [
                BoxShadow(
                  color: AppColors.dropShadow.withOpacity(0.1),
                  blurRadius: 1,
                  offset: const Offset(0, -1),
                ),
              ],
      ),
      child: child,
    );
  }
}
