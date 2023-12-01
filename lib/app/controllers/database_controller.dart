import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spisymobile_test/app/bloc/list_users_cubit.dart';
import 'package:spisymobile_test/app/config/function_utils.dart';
import 'package:spisymobile_test/app/data_models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class DatabaseController extends GetxController {
  // final _dbPath = '/assets/test_database.db';
  final _dbPath = 'my_database.db';
  late Database _db;

  void dropTable() async {
    await _db.execute('DROP TABLE user');
  }

  void _createTable() async {
    final isExist = await _doesTableExist('user');
    logKey('isExist', isExist);
    if (isExist) {
      return;
    }
    const query = ''' 
    CREATE TABLE user (
      id TEXT PRIMARY KEY,
      name TEXT,
      gender BOOLEAN,
      birth_date DATETIME,
      age INTEGER,
      address TEXT
    );
    ''';
    await _db.execute(query);
  }

  void initdatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    var _path = '${dir.path}$_dbPath';
    _db = await openDatabase(_path);
    final path = await getDatabasesPath();
    logKey('path', path);
    _createTable();
  }

  @override
  void onInit() {
    super.onInit();
    initdatabase();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> dummyInsert() async {
    final uuid = Uuid().v4();
    final age = calcAge(DateTime(1999, 1, 26));
    final dummy = UserModel(
      uuid: uuid,
      name: 'Rifqi Rahmad Dummy',
      birthDate: DateTime(1999, 1, 26),
      gender: true,
      address: 'address dummy',
      age: age,
    );
    final res = await createUser(data: dummy);
    logKey('dummyInsert', res);
  }

  Future<List<UserModel>> getAllUsers({bool refreshList = false}) async {
    const query = ''' 
    SELECT * FROM user;
    ''';
    try {
      final res = await _db.rawQuery(query);
      if (isEmpty(res)) {
        return [];
      }
      var temp = <UserModel>[];
      for (var i = 0; i < res.length; i++) {
        final data = UserModel.fromJson(res[i]);
        temp.add(data);
      }
      if (refreshList) {
        final listuserCubit = Get.context!.read<ListUsersCubit>();
        listuserCubit.udpateUsers(temp);
      }
      return temp;
    } catch (e) {
      logKey('error getAllUsers', e);
      return [];
    }
  }

  Future<List?> createUser({required UserModel data}) async {
    var query = ''' 
    INSERT INTO user (id, name, gender, birth_date, age, address)
    VALUES ('${data.uuid}', '${data.name}', ${data.gender ? 1 : 0}, '${data.birthDate.toIso8601String()}', ${data.age}, '${data.address}');
    ''';
    logKey('query createUser', query);
    try {
      final res = await _db.rawQuery(query);
      return res;
    } catch (e) {
      logKey('error createUser', e.toString());
      return null;
    }
  }

  Future<List?> updateUser(UserModel data) async {
    try {
      var query = ''' 
        UPDATE user SET name = '${data.name}', gender = ${data.gender ? 1 : 0}, birth_date = '${data.birthDate.toIso8601String()}', age = ${data.age}, address ='${data.address}'
        WHERE id = '${data.uuid}'
      ''';
      final res = await _db.rawQuery(query);
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<List?> deleteUser(String id) async {
    try {
      var query = ''' 
    DELETE FROM user WHERE id = '$id'
    ''';
      final res = await _db.rawQuery(query);
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<bool> _doesTableExist(String tableName) async {
    try {
      // Database database = await openDatabase(
      //   join(await getDatabasesPath(), 'your_database_name.db'),
      // );

      List<Map<String, dynamic>> result = await _db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
      );

      return result.isNotEmpty;
    } catch (e) {
      print('Error checking table existence: $e');
      return false;
    }
  }
}
