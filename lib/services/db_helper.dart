import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'glanz_db.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT UNIQUE NOT NULL,
            password TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> createUser(String name, String password) async {
    final db = await database;
    return await db.insert('users', {
      'name': name,
      'password': password,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String> getUserLocation() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'settings',
      columns: ['location'],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['location'] as String;
    } else {
      return '';
    }
  }

  Future<void> saveUserLocation(String location) async {
    final db = await database;
    await db.insert('settings', {
      'location': location,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateLoggedInStatus(bool status) async {
    final db = await database;

    await db.update(
      'user_status',
      {'loggedInStat': status ? 1 : 0},
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  Future<bool> authenticateUser(String name, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'name = ? AND password = ?',
      whereArgs: [name, password],
    );
    return result.isNotEmpty;
  }

  Future<String> getUserFullName() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['name'],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['name'] as String;
    } else {
      return 'Guest';
    }
  }

  Future<bool> checkIfTableExists(String tableName) async {
    final db = await database;
    var result = await db.rawQuery(
      '''
      SELECT name FROM sqlite_master WHERE type='table' AND name=?;
      ''',
      [tableName],
    );

    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getDataFromTable(String tableName) async {
    final db = await database;
    var result = await db.query(tableName);
    return result;
  }

  Future<void> deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'glanz_db.db');

    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}
