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

  // Create a new user
  Future<int> createUser(String name, String password) async {
    final db = await database;
    return await db.insert(
      'users',
      {'name': name, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch full name of the first user in the database
  Future<String> getUserFullName() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['name'],
      limit: 1, // Fetch only the first user
    );

    if (result.isNotEmpty) {
      return result.first['name'] as String;
    } else {
      return 'Guest'; // Default value if no user is found
    }
  }
}
