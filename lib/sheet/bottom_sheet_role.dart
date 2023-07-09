import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/get/models.dart';
import 'package:todo/resource/app_colors.dart';
import 'package:todo/resource/app_lists.dart';

class BottomSheetRole extends StatefulWidget {
  final Function(ModelRole)? onSelection;
  const BottomSheetRole({Key? key, this.onSelection}) : super(key: key);

  @override
  State<BottomSheetRole> createState() => _BottomSheetRoleState();
}

class _BottomSheetRoleState extends State<BottomSheetRole> {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: AppLists.roleList.length,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                color: AppColors.dividerColor,
                height: 0.5,
              );
            },
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  widget.onSelection!(AppLists.roleList[index]);
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child: Text(
                    AppLists.roleList[index].title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
