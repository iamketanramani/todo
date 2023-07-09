import 'dart:async';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/resource/app_helper.dart';

class DatabaseHelper {
  // Create DatabaseHelper Instance => final dbHelper = DatabaseHelper.instance;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  static const _databaseName = 'todo.db';
  static const _databaseVersion = 1;

  static const tableEmployee = 'tbl_employee';

  static const colId = 'id';
  static const colName = 'employee_name';
  static const colRole = 'role';
  static const colFromDate = 'from_date';
  static const colToDate = 'to_date';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /* Future<Database> */
  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    AppHelper.showLog('Database: Location: $path');

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  Future<void> cleanDatabase() async {
    try {
      Database db = await instance.database;
      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete(tableEmployee);

        await batch.commit();
      });
      AppHelper.showLog('Database: Clear Successfully');
    } catch (error) {
      AppHelper.showLog('Database: Clear Error: ${error.toString()}');
    }
  }

  void _onCreateDB(Database db, int version) async {
    String sqlTableEmployee = '''
    CREATE TABLE $tableEmployee(
      $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $colName TEXT,
      $colRole TEXT,
      $colFromDate TEXT,
      $colToDate TEXT
    )
    ''';

    await db.execute(sqlTableEmployee);
  }

  /* Future<List<ModelEmployee>> getAllEmployee() async {
    Database db = await instance.database;
    final List<Map<String, Object?>> result = await db.query(tableEmployee);
    return result.map((e) => ModelEmployee.fromJson(e)).toList();
  } */

  // Method to Insert Record
  Future<int> insert(String tableName, Map<String, dynamic> data) async {
    Database db = await instance.database;
    return await db.insert(tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Method to Update Record
  Future<int> update(
    String tableName, {
    required String whereColumn,
    required int whereColumnValue,
    required Map<String, dynamic> data,
  }) async {
    Database db = await instance.database;
    var result = await db.update(tableName, data,
        where: '$whereColumn = ?',
        whereArgs: [whereColumnValue],
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  // Method to Delete Specific Records from Table Specified
  Future<int> delete(String tableName,
      {required String whereColumn, required int whereColumnValue}) async {
    Database db = await instance.database;
    var result = await db.delete(tableName,
        where: '$whereColumn = ?', whereArgs: [whereColumnValue]);
    return result;
  }

  // Method to Get All Records from Table Specified
  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // Method to Get Specific Records from Table Specified
  Future<List<Map<String, dynamic>>> querySpecific(String tableName,
      {required String whereColumn, required dynamic whereColumnValue}) async {
    Database db = await instance.database;
    var result = await db.rawQuery(
        'SELECT * FROM $tableName WHERE $whereColumn = ?', [whereColumnValue]);
    return result;
  }

  // Custom Query
  Future<List<Map<String, dynamic>>> customQuery(String query) async {
    Database db = await instance.database;
    var result = await db.rawQuery(query);
    return result;
  }

  // Method to Get Last Inserted Row ID from Table Specified
  Future<int> lastId(String table) async {
    // ignore: prefer_typing_uninitialized_variables
    var lastId;
    Database db = await instance.database;
    var result = await db.rawQuery('SELECT COUNT(*) FROM $table');
    for (var element in result) {
      lastId = element['COUNT(*)'];
    }
    return lastId;
  }

  // Method to Get Last Inserted Row from Table Specified
  Future<Map<String, dynamic>> lastRow(String table, String primaryKey) async {
    Map<String, dynamic> data = {};

    // ignore: prefer_typing_uninitialized_variables
    var lId;
    await lastId(table).then((value) {
      lId = value;
    });

    if (lId == 0) {
      data = {};
    } else {
      await querySpecific(table, whereColumn: primaryKey, whereColumnValue: lId)
          .then((value) {
        data = value[0];
      });
    }

    return data;
  }

  //Delete all records from table
  Future deleteTableData(String tableName) async {
    Database db = await instance.database;
    var result = await db.query("DELETE FROM $tableName");
    return result;
  }
}
