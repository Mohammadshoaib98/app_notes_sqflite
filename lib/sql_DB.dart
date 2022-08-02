import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  //this method called onece when app initial database it.
  //but we can call it when we change version it by onUbgrade method
  initialDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'DataBase.db');
    Database mybd = await openDatabase(path,
        onCreate: _onCreate, version: 4, onUpgrade: _onUpgrade);
    return mybd;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('************upgrade*************');

  }

  _onCreate(Database db, int version) async {
    print('***********onCreate***********');

    try {
   await db.execute(
          'CREATE TABLE Notes (id INTEGER PRIMARY KEY autoincrement, title TEXT,note TEXT,color TEXT)'
      );
        /*'''
    CREATE TABLE "notes"
    (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL,
    "color" TEXT NOT NULL,
    )
    ''');*/
    } catch (e) {
      print(e);
    }
  }

  readData(String sql) async {
    print('************readData*************');

    try {
      Database? mydb = await db;
      List<Map> response = await mydb!.rawQuery(sql);
      return response;
    } catch (e) {
      print(e);
    }
  }

  insertData(String sql) async {
    print('***********insertData************');

    try {
      Database? mydb = await db;
      int response = await mydb!.rawInsert(sql);
      return response;
    } catch (e) {


      print(e);
    }
  }

  updateData(String sql) async {
    print('**************updateData**************');

    try {
      Database? mydb = await db;
      int response = await mydb!.rawUpdate(sql);
      return response;
    } catch (e) {
      print(e);
    }
  }

  deleteData(String sql) async {
    print('**************deleteData*************');

    try {
      Database? mydb = await db;
      int response = await mydb!.rawDelete(sql);
      return response;
    } catch (e) {
      print(e);
    }
  }

  ResetDatabase() async {
    print('**************RestDatabase**************');

    try {
      String databasepath = await getDatabasesPath();
      String path = join(databasepath, 'DataBase.db');
      await deleteDatabase(path);
    } catch (e) {
      print(e);
    }
  }
 



}
