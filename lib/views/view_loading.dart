import 'package:flutter/material.dart';
import 'package:todo/resource/app_colors.dart';
import 'package:todo/views/staggered_dots_wave.dart';

class ViewLoading extends StatelessWidget {
  final double? height;
  const ViewLoading({this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StaggeredDotsWave(
        color: AppColors.primaryColor,
        size: 30,
      ),
    );
  }
}
