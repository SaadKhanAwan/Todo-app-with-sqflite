import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

import '../widget/employe_model.dart';

class DB_helper {
  // this is use to write a database
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initdatabase();
    }
    return _db!;
  }

  //Employee.db is name make it like model name
  initdatabase() async {
    io.Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, 'Employee.db');
    var db = await openDatabase(path, version: 1, onCreate: _oncreate);
    return db;
  }

  // this is table for database
  _oncreate(Database db, int version) async {
    await db.execute('''CREATE TABLE Employee(
        id INTEGER PRIMARY KEY, 
        name TEXT,
        salary INTEGER,
        profetion TEXT        
        )
        ''');
  }

  // the name use in table in "" will be same here which is in ""
  //this is for insert data
  Future<Employee> insert(Employee employ) async {
    var dbClient = await db;
    await dbClient!.insert("Employee", employ.toMap());
    return employ;
  }

  //this for for get data on screen
  Future<List<Employee>> Get_Empolye_list() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('Employee');
    return queryResult.map((e) => Employee.fromMap(e)).toList();
  }

  // this is for delete data
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('Employee', where: 'id =?', whereArgs: [id]);
  }

  // this is  for update data
  Future<int> updateQuantity(Employee empolye) async {
    var dbClient = await db;
    return await dbClient!.update('Employee', empolye.toMap(),
        where: 'id =?', whereArgs: [empolye.id]);
  }
}
