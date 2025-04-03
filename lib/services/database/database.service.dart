import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './models/common.model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'common_model.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE common_model (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> create(CommonModel model) async {
    final db = await database;
    return await db.insert('common_model', model.toMap());
  }

  Future<List<CommonModel>> readAll() async {
    final db = await database;
    final result = await db.query('common_model');
    return result.map((map) => CommonModel.fromMap(map)).toList();
  }

  Future<CommonModel?> read(int id) async {
    final db = await database;
    final result = await db.query(
      'common_model',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return CommonModel.fromMap(result.first);
    }
    return null;
  }

  Future<int> update(CommonModel model) async {
    final db = await database;
    return await db.update(
      'common_model',
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('common_model', where: 'id = ?', whereArgs: [id]);
  }
}
