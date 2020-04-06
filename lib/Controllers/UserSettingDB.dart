import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserSettingDB with ChangeNotifier{

  Database database;

//  UserSettingDB(){
//    _init();
//  }

  final String _databaseName = 'demo.db';
  final String _tableName = 'Test';
  final int _columnId = 1;
  final String _columnName = 'name';

  Future<Database> _init() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, this._databaseName);

    this.database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''CREATE TABLE $_tableName(
            $_columnId INTEGER PRIMARY KEY, 
            $_columnName TEXT)
          ''');
      });
    return database;
  }

  Future<List<Map<String, dynamic>>> settingGet() async{
    return await this.database.query(this._tableName);
  }

  Future settingInsert({int id, String name}) async{
    await this.database.rawInsert(
      '''
        INSERT INTO $_tableName(id, name) VALUES(?, ?)
      ''',
      [id, name]
    );
  }


}