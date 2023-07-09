import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:todo/get/controller.dart';
import 'package:todo/get/models.dart';
import 'package:todo/resource/app_assets.dart';
import 'package:todo/resource/app_colors.dart';
import 'package:todo/resource/app_enums.dart';
import 'package:todo/resource/app_helper.dart';
import 'package:todo/resource/app_strings.dart';
import 'package:todo/resource/app_styles.dart';
import 'package:todo/resource/validation_helper.dart';
import 'package:todo/sheet/bottom_sheet_role.dart';
import 'package:todo/views/bottom_shadow_container.dart';
import 'package:todo/views/calendar.dart';
import 'package:todo/views/primary_button.dart';
import 'package:todo/views/secondary_button.dart';
import 'package:todo/views/toast.dart';

class ScreenAddEmployees extends GetView<ControllerAddEmployee> {
  static String pageId = "/ScreenAddEmployees";

  ScreenAddEmployees({Key? key}) : super(key: key);

  final controllerr = Get.put(ControllerAddEmployee());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leadingWidth: 0,
          leading: const SizedBox(width: 0),
          title: Obx(
            () => Text(
              controllerr.action.value == ActionEmployee.add
                  ? AppStrings.strAddEmployeeDetails
                  : AppStrings.strEditEmployeeDetails,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          actions: [
            Obx(() {
              if (controllerr.action.value == ActionEmployee.edit) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        controllerr.confirmDelete(context);
                      },
                      splashRadius: (kToolbarHeight * 0.90) / 2,
                      constraints: const BoxConstraints(
                        maxHeight: kToolbarHeight * 0.65,
                        maxWidth: kToolbarHeight * 0.65,
                      ),
                      icon: SvgPicture.asset(
                        AppAssets.icDelete,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: BottomShadowContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SecondaryButton(
                  width: 100,
                  text: AppStrings.strCancel,
                  onPressed: () {
                    Get.back();
                  },
                ),
                const SizedBox(width: 10),
                PrimaryButton(
                  width: 100,
                  text: AppStrings.strSave,
                  onPressed: () {
                    formKey.currentState!.save();
                    if (formKey.currentState!.validate()) {
                      controllerr.addEmployee(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Employee Name
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      TextFormField(
                        controller: controllerr.tcName,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        inputFormatters:
                            ValidationHelper.allowCharactersWithSpace,
                        textCapitalization: TextCapitalization.words,
                        style: AppStyles.etTextStyle,
                        decoration: AppStyles.etDecoration(
                          hintText: AppStrings.strEmployeename,
                          havePrefix: true,
                        ),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return AppStrings.strEnteremployeename;
                          } else {
                            return null;
                          }
                        }),
                        onSaved: ((value) {
                          controllerr.employeeModel.value.employeeName = value!;
                        }),
                      ),
                      //Prefix
                      Positioned(
                        left: 15,
                        top: 0,
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: SvgPicture.asset(AppAssets.icName),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Role
                  InkWell(
                    onTap: () {
                      AppHelper.hideKeyboard(context);
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        enableDrag: true,
                        // isDismissible: false,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        builder: (BuildContext ctx) {
                          return BottomSheetRole(
                            onSelection: (ModelRole role) {
                              controllerr.updateRole(role);
                            },
                          );
                        },
                      );
                    },
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        TextFormField(
                          enabled: false,
                          controller: controllerr.tcRole,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          inputFormatters:
                              ValidationHelper.allowCharactersWithSpace,
                          textCapitalization: TextCapitalization.words,
                          style: AppStyles.etTextStyle,
                          decoration: AppStyles.etDecoration(
                            hintText: AppStrings.strSelectrole,
                            havePrefix: true,
                            havePostfix: true,
                          ),
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return AppStrings.strSelectrole;
                            } else {
                              return null;
                            }
                          }),
                          onSaved: ((value) {
                            controllerr.employeeModel.value.role =
                                controllerr.role.value.id!;
                          }),
                        ),
                        //Prefix
                        Positioned(
                          left: 15,
                          top: 0,
                          child: Container(
                            height: 48,
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: SvgPicture.asset(AppAssets.icRole),
                            ),
                          ),
                        ),
                        //Postfix
                        Positioned(
                          right: 15,
                          top: 0,
                          child: Container(
                            height: 48,
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 24,
                              width: 12,
                              child: SvgPicture.asset(AppAssets.icDropdown),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Date
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // From Date
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            AppHelper.hideKeyboard(context);
                            await showDialog(
                              context: context,
                              builder: (builderContext) {
                                return AlertDialog(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  content: StatefulBuilder(
                                    builder: (ctx, StateSetter setState) {
                                      return Calendar(
                                        // minDate: controllerr.fromDate.value,
                                        // maxDate: controllerr.getToday(),
                                        onDateSelected: (date) {
                                          controllerr.updateStartDate(date);
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              TextFormField(
                                enabled: false,
                                controller: controllerr.tcFromDate,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                inputFormatters:
                                    ValidationHelper.allowCharactersWithSpace,
                                textCapitalization: TextCapitalization.words,
                                style: AppStyles.etTextStyle,
                                decoration: AppStyles.etDecoration(
                                  hintText: AppStrings.strFromdate,
                                  havePrefix: true,
                                ),
                                validator: ((value) {
                                  if (value!.isEmpty) {
                                    return AppStrings.strSelectfromdate;
                                  } else {
                                    return null;
                                  }
                                }),
                                onSaved: ((value) {
                                  controllerr.employeeModel.value.fromDate =
                                      controllerr.fromDate.value;
                                }),
                              ),
                              //Prefix
                              Positioned(
                                left: 15,
                                top: 0,
                                child: Container(
                                  height: 48,
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child:
                                        SvgPicture.asset(AppAssets.icCalendar),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: SvgPicture.asset(AppAssets.icArrow),
                      ),
                      // To Date
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            AppHelper.hideKeyboard(context);
                            if (controllerr.fromDate.value.isEmpty) {
                              Toast.show(
                                  context, AppStrings.strPleaseSelectFromDate);
                              return;
                            }
                            await showDialog(
                              context: context,
                              builder: (builderContext) {
                                return AlertDialog(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  content: StatefulBuilder(
                                    builder: (ctx, StateSetter setState) {
                                      return Calendar(
                                        minDate: controllerr.fromDate.value,
                                        onDateSelected: (date) {
                                          controllerr.updateEndDate(date);
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              TextFormField(
                                enabled: false,
                                controller: controllerr.tcToDate,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                inputFormatters:
                                    ValidationHelper.allowCharactersWithSpace,
                                textCapitalization: TextCapitalization.words,
                                style: AppStyles.etTextStyle,
                                decoration: AppStyles.etDecoration(
                                  hintText: AppStrings.strTodate,
                                  havePrefix: true,
                                ),
                                validator: ((value) {
                                  String fromDate = controllerr.fromDate.value;
                                  String toDate = controllerr.toDate.value;

                                  if (fromDate.isNotEmpty &&
                                      toDate.isNotEmpty) {
                                    if (AppHelper.compareDate(
                                            date1: fromDate, date2: toDate) ==
                                        DateStatus.after) {
                                      Toast.show(context,
                                          AppStrings.strAlertDateInvalid);
                                    } else {
                                      return null;
                                    }
                                  }

                                  return null;
                                }),
                                onSaved: ((value) {
                                  controllerr.employeeModel.value.toDate =
                                      controllerr.toDate.value;
                                }),
                              ),
                              //Prefix
                              Positioned(
                                left: 15,
                                top: 0,
                                child: Container(
                                  height: 48,
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child:
                                        SvgPicture.asset(AppAssets.icCalendar),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
