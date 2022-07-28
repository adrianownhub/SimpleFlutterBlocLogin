import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/time.dart';

class TimeDatabase{
  static final TimeDatabase instance = TimeDatabase._init();

  static Database _database;

  TimeDatabase._init();

  Future<Database> get database async{
    if(_database != null) return _database;

    _database = await _initDB('time.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }


  Future _createDB(Database db, int version) async{
    final idType ='INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $timeTable (
    ${TimeFields.id} $idType,
    ${TimeFields.email} $textType,
    ${TimeFields.createdTime} $textType) 
    ''');
  }
  
  Future<Time> create(Time time) async{
    final db = await instance.database;

    // final json = time.toJson();
    // final columns = '${TimeFields.email},${TimeFields.createdTime}';
    // final values ="[${json[TimeFields.email]}], [${json[TimeFields.createdTime]}]";
    // final id = await db.rawInsert('INSERT INTO $timeTable($columns) VALUES ($values)');
    
    final id = await db.insert(timeTable, time.toJson());
    return time.copy(id: id);
  }

  Future<List<Time>> readTime() async{
    final db = await instance.database;

    final orderBy = '${TimeFields.id} ASC';
    final result = await db.query(timeTable, orderBy: orderBy);

    return result.map((json)=> Time.fromJson(json)).toList();

  }

  Future close() async{
    final db = await instance.database;

    db.close();
  }
}