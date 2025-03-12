import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      log("Database already initialized");
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'medicines.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE medicines (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        dosage TEXT,
        frequency TEXT,
        endDate TEXT
      )
    ''');
    log("Database created ++++++++bro");

    await db.execute('''
  CREATE TABLE appointments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    doctorName TEXT NOT NULL,
    notes TEXT,
    date TEXT,
    time TEXT
  )
''');
  }

  insertData(String sql) async {
    // here we use the get db function
    Database mydb = await database;
    //Executes a raw SQL INSERT query and returns the last inserted row ID.
    int response = await mydb.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    // here we use the get db function
    Database? mydb = await database;
    //Executes a raw SQL INSERT query and returns the last inserted row ID.
    int response = await mydb.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    // here we use the get db function
    Database? mydb = await database;
    //Executes a raw SQL INSERT query and returns the last inserted row ID.
    int response = await mydb.rawDelete(sql);
    return response;
  }

  selectData(String sql) async {
    // here we use the get db function
    Database? mydb = await database;
    List<Map<String, Object?>> response = await mydb.rawQuery(sql);
    return response;
  }
}
