import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/database/database_helper.dart';
import 'package:todo/get/controllers/base_controller.dart';
import 'package:todo/get/models.dart';
import 'package:todo/resource/app_assets.dart';
import 'package:todo/resource/app_enums.dart';
import 'package:todo/resource/app_helper.dart';
import 'package:todo/resource/app_lists.dart';
import 'package:todo/resource/app_log.dart';
import 'package:todo/resource/app_strings.dart';
import 'package:todo/resource/app_styles.dart';
import 'package:todo/views/primary_button.dart';
import 'package:todo/views/secondary_button.dart';
import 'package:todo/views/toast.dart';

class ControllerAddEmployee extends BaseController {
  @override
  void errorHandler() {}

  var tcName = TextEditingController();
  var tcRole = TextEditingController();
  var tcFromDate = TextEditingController();
  var tcToDate = TextEditingController();
  var role = ModelRole(id: '', title: '').obs;

  var fromDate = ''.obs;
  var toDate = ''.obs;

  var employeeModel = ModelEmployee().obs;

  dynamic argumentData = Get.arguments;
  var activityId = ''.obs;
  var activityTitle = ''.obs;
  Rx<ActionEmployee> action = Rx<ActionEmployee>(ActionEmployee.none);
  var idToUpdate = 0.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      Map<String, dynamic> map = argumentData;
      ActionEmployee argAction = map['action'] as ActionEmployee;
      action.value = argAction;

      if (action.value == ActionEmployee.edit) {
        ModelEmployee argModel = map['data'] as ModelEmployee;
        idToUpdate.value = argModel.id!;

        tcName.text = argModel.employeeName!;
        tcRole.text = getRoleFromId(argModel.role!);
        role.value = ModelRole(id: argModel.role, title: tcRole.text);

        if (argModel.fromDate!.isNotEmpty) {
          fromDate.value = argModel.fromDate!;
          tcFromDate.text = AppHelper.changeDateForat(
            argModel.fromDate!,
            fromFormat: AppStrings.dfYMD,
            toformat: AppStrings.dfCalendarDialog,
          );
        }

        if (argModel.toDate!.isNotEmpty) {
          toDate.value = argModel.toDate!;
          tcToDate.text = AppHelper.changeDateForat(
            argModel.toDate!,
            fromFormat: AppStrings.dfYMD,
            toformat: AppStrings.dfCalendarDialog,
          );
        }
      }
    }

    super.onInit();
  }

  String getRoleFromId(String id) {
    return AppLists.roleList
        .firstWhere((element) => element.id == id.toString())
        .title!;
  }

  void updateRole(ModelRole model) {
    role.value = model;
    tcRole.text = model.title!;
    role.refresh();
    update();
  }

  void updateStartDate(String date) {
    if (date.isEmpty) {
    } else {
      fromDate.value = date;
      tcFromDate.text = AppHelper.changeDateForat(
        date,
        fromFormat: AppStrings.dfYMD,
        toformat: AppStrings.dfCalendarDialog,
      );

      toDate.value = '';
      tcToDate.text = '';
    }
  }

  void updateEndDate(String date) {
    if (date.isEmpty) {
      toDate.value = '';
      tcToDate.text = '';
    } else {
      toDate.value = date;
      tcToDate.text = AppHelper.changeDateForat(
        date,
        fromFormat: AppStrings.dfYMD,
        toformat: AppStrings.dfCalendarDialog,
      );
    }
  }

  String getToday() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  @override
  void onClose() {
    tcName.dispose();
    tcFromDate.dispose();
    tcToDate.dispose();
    super.onClose();
  }

  final dbHelper = DatabaseHelper.instance;

  void addEmployee(context) async {
    if (action.value == ActionEmployee.add) {
      // Check employee name exist
      Database db = await dbHelper.database;
      String sql =
          "SELECT ${DatabaseHelper.colName} FROM ${DatabaseHelper.tableEmployee} WHERE ${DatabaseHelper.colName} LIKE '%${employeeModel.value.employeeName}%'";
      List<Map> companyNameExist = await db.rawQuery(sql, []);
      AppLog.d('Result: ${companyNameExist.toString()}');
      if (companyNameExist.isNotEmpty) {
        for (int i = 0; i < companyNameExist.length; i++) {
          if (companyNameExist[i][DatabaseHelper.colName]
                  .toString()
                  .toLowerCase()
                  .trim() ==
              employeeModel.value.employeeName!.toLowerCase().trim()) {
            Toast.show(context,
                'Employee name is already in use kindly use another name');
            return;
          }
        }
      }

      await dbHelper
          .insert(DatabaseHelper.tableEmployee, employeeModel.toJson())
          .then((value) {
        AppHelper.showLog('Ketan:: Add Employee $value');
        Toast.show(context, 'Employee Added Successfully');
        Get.back();
      }).onError((error, stackTrace) {
        AppHelper.showLog('Ketan:: Add Employee Error: ${error.toString()}');
      });
    } else if (action.value == ActionEmployee.edit) {
      employeeModel.value.id = idToUpdate.value;

      await dbHelper
          .update(DatabaseHelper.tableEmployee,
              whereColumn: DatabaseHelper.colId,
              whereColumnValue: idToUpdate.value,
              data: employeeModel.toJson())
          .then((value) {
        AppHelper.showLog('Ketan:: Edit Employee $value');
        Toast.show(context, 'Employee Edited Successfully');
        Get.back();
      }).onError((error, stackTrace) {
        AppHelper.showLog('Ketan:: Edit Employee Error: ${error.toString()}');
      });
    }
  }

  void confirmDelete(context) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AppStyles.customDialog(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: SvgPicture.asset(
                    AppAssets.icAlertGray,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  AppStrings.strAlertDeleteEmployee,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        height: 40,
                        text: AppStrings.strNo,
                        onPressed: (() {
                          Get.back();
                        }),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: PrimaryButton(
                        height: 40,
                        text: AppStrings.strYes,
                        onPressed: () {
                          Get.back();
                          deleteEmployee(idToUpdate.value).whenComplete(() {
                            Get.back();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> deleteEmployee(int id) async {
    String sql =
        '''DELETE FROM ${DatabaseHelper.tableEmployee} WHERE ${DatabaseHelper.colId}='$id'
        ''';
    AppHelper.showLog('Ketan:: Employee Delete: $sql');
    await dbHelper.customQuery(sql);
  }
}
