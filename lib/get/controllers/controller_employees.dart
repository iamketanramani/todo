import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/database/database_helper.dart';
import 'package:todo/get/controllers/base_controller.dart';
import 'package:todo/models/model_employee.dart';
import 'package:todo/resource/app_helper.dart';
import 'package:todo/resource/app_lists.dart';

class ControllerEmployees extends BaseController {
  @override
  void errorHandler() {}

  @override
  void onInit() {
    super.onInit();
    getEmployee();
  }

  final dbHelper = DatabaseHelper.instance;

  final currentEmployee = <ModelEmployee>[].obs;
  final previousEmployee = <ModelEmployee>[].obs;

  String getRoleFromId(String id) {
    return AppLists.roleList
        .firstWhere((element) => element.id == id.toString())
        .title!;
  }

  var isFetchingData = false.obs;
  Future<void> getEmployee() async {
    isFetchingData.value = true;
    currentEmployee.clear();
    previousEmployee.clear();

    try {
      String sqlCurrent =
          '''SELECT * FROM ${DatabaseHelper.tableEmployee} WHERE ${DatabaseHelper.tableEmployee}.${DatabaseHelper.colToDate}=''
          ''';
      List<Map<String, dynamic>> listCurrent =
          await dbHelper.customQuery(sqlCurrent);
      AppHelper.showLog(
          'SQL_EmployeeList_Current (${listCurrent.length}): $sqlCurrent');
      currentEmployee.value =
          listCurrent.map((m) => ModelEmployee.fromJson(m)).toList();

      String sqlPrevious =
          '''SELECT * FROM ${DatabaseHelper.tableEmployee} WHERE ${DatabaseHelper.tableEmployee}.${DatabaseHelper.colToDate}!=''
          ''';
      List<Map<String, dynamic>> listPrevious =
          await dbHelper.customQuery(sqlPrevious);
      AppHelper.showLog(
          'SQL_EmployeeList_Previous (${listPrevious.length}): $sqlPrevious');
      previousEmployee.value =
          listPrevious.map((m) => ModelEmployee.fromJson(m)).toList();

      update();
    } catch (e) {
      AppHelper.showLog("RL_RetailerList_Error: ${e.toString()}");
    } finally {
      currentEmployee.refresh();
      previousEmployee.refresh();
      isFetchingData.value = false;
      update();
    }
  }

  Future<void> removeCurrentEmployeeAt(context, int index) async {
    ModelEmployee model = currentEmployee[index];

    currentEmployee.removeAt(index);
    currentEmployee.refresh();

    bool isUndoClicked = false;

    final snackBar = SnackBar(
      content: const Text('Employee data has been deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          isUndoClicked = true;

          currentEmployee.insert(index, model);
          currentEmployee.refresh();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((value) {
      if (!isUndoClicked) {
        // Delete from db
        deleteEmployee(model.id!);
      }
    });
  }

  Future<void> removePreviousEmployeeAt(context, int index) async {
    ModelEmployee model = previousEmployee[index];

    previousEmployee.removeAt(index);
    previousEmployee.refresh();

    bool isUndoClicked = false;

    final snackBar = SnackBar(
      content: const Text('Employee data has been deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          isUndoClicked = true;

          previousEmployee.insert(index, model);
          previousEmployee.refresh();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((value) {
      if (!isUndoClicked) {
        // Delete from db
        deleteEmployee(model.id!);
      }
    });
  }

  Future<void> deleteEmployee(int id) async {
    String sql =
        '''DELETE FROM ${DatabaseHelper.tableEmployee} WHERE ${DatabaseHelper.colId}='$id'
        ''';
    AppHelper.showLog('Ketan:: Employee Delete: $sql');
    await dbHelper.customQuery(sql);
  }
}
