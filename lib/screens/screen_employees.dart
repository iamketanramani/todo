import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:todo/get/controller.dart';
import 'package:todo/get/models.dart';
import 'package:todo/get/screen.dart';
import 'package:todo/resource/app_assets.dart';
import 'package:todo/resource/app_colors.dart';
import 'package:todo/resource/app_enums.dart';
import 'package:todo/resource/app_helper.dart';
import 'package:todo/resource/app_strings.dart';
import 'package:todo/views/view_loading.dart';

class ScreenEmployees extends GetView<ControllerEmployees> {
  static String pageId = "/ScreenEmployees";

  ScreenEmployees({Key? key}) : super(key: key);

  final controllerr = Get.put(ControllerEmployees());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.dividerColor,
        appBar: AppBar(
          title: const Text(
            AppStrings.strEmployeeList,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            Get.toNamed(ScreenAddEmployees.pageId, arguments: {
              'action': ActionEmployee.add,
            })!
                .whenComplete(() {
              controllerr.getEmployee();
            });
          },
          child: SvgPicture.asset(
            AppAssets.icPlus,
            width: 18,
            height: 18,
          ),
        ),
        body: SafeArea(
          child: Obx(
            () {
              if (controllerr.isFetchingData.value) {
                // Fetching data from database is ongoing. So, Display loader
                return const Center(child: ViewLoading());
              } else if (controllerr.currentEmployee.isEmpty &&
                  controllerr.previousEmployee.isEmpty) {
                // Fetching data from database success but no result found
                return Center(child: SvgPicture.asset(AppAssets.imgNoEmployee));
              } else {
                // Fetching data from database success and found data
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Current Employee
                      if (controllerr.currentEmployee.isNotEmpty)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Text(
                                AppStrings.strCurrentemployees,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              color: AppColors.backgroundColor,
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return Container(
                                    color: AppColors.dividerColor,
                                    height: 1,
                                  );
                                },
                                itemCount: controllerr.currentEmployee.length,
                                itemBuilder: (context, index) {
                                  ModelEmployee model =
                                      controllerr.currentEmployee[index];
                                  return Slidable(
                                    key: Key(model.toString()),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.20,
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          icon: Icons.delete,
                                          backgroundColor: AppColors.redColor,
                                          onPressed: (BuildContext context) {
                                            controllerr.removeCurrentEmployeeAt(
                                                context, index);
                                          },
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(ScreenAddEmployees.pageId,
                                                arguments: {
                                              'action': ActionEmployee.edit,
                                              'data': model,
                                            })!
                                            .whenComplete(() {
                                          controllerr.getEmployee();
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              model.employeeName!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              controllerr
                                                  .getRoleFromId(model.role!),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: AppColors.hintColor,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '${AppStrings.strFrom}${AppHelper.changeDateForat(
                                                model.fromDate!,
                                                fromFormat: AppStrings.dfYMD,
                                                toformat:
                                                    AppStrings.dfCalendarDialog,
                                              )}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: AppColors.hintColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                      // Previous Employee
                      if (controllerr.previousEmployee.isNotEmpty)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Text(
                                AppStrings.strPreviousemployees,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              color: AppColors.backgroundColor,
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return Container(
                                    color: AppColors.dividerColor,
                                    height: 1,
                                  );
                                },
                                itemCount: controllerr.previousEmployee.length,
                                itemBuilder: (context, index) {
                                  ModelEmployee model =
                                      controllerr.previousEmployee[index];
                                  return Slidable(
                                    key: Key(model.toString()),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.20,
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          icon: Icons.delete,
                                          backgroundColor: AppColors.redColor,
                                          onPressed: (BuildContext context) {
                                            controllerr
                                                .removePreviousEmployeeAt(
                                                    context, index);
                                          },
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(ScreenAddEmployees.pageId,
                                                arguments: {
                                              'action': ActionEmployee.edit,
                                              'data': model,
                                            })!
                                            .whenComplete(() {
                                          controllerr.getEmployee();
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              model.employeeName!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              controllerr
                                                  .getRoleFromId(model.role!),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: AppColors.hintColor,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '${AppHelper.changeDateForat(
                                                model.fromDate!,
                                                fromFormat: AppStrings.dfYMD,
                                                toformat:
                                                    AppStrings.dfCalendarDialog,
                                              )} - ${AppHelper.changeDateForat(
                                                model.toDate!,
                                                fromFormat: AppStrings.dfYMD,
                                                toformat:
                                                    AppStrings.dfCalendarDialog,
                                              )}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: AppColors.hintColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
