import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './models/common.model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Placeholder for creating tables dynamically
      },
    );
  }

  Future<void> createTable<T extends CommonModel>(T model) async {
    final db = await database;
    final tableName = model.tableName;
    final columns = model.columns;

    final columnDefinitions = columns.entries
        .map((entry) => '${entry.key} ${entry.value}')
        .join(', ');

    final createTableQuery =
        'CREATE TABLE IF NOT EXISTS $tableName ($columnDefinitions)';
    print('Creating table: $createTableQuery');

    await db.execute(createTableQuery);
  }

  Future<int> insert<T extends CommonModel>(T model) async {
    final db = await database;

    // final countQuery = await db.rawQuery(
    //   'SELECT COUNT(*) as count FROM ${model.tableName}',
    // );
    // final count = Sqflite.firstIntValue(countQuery) ?? 0;
    // model.id = count + 1;

    print('Inserting into table ${model.tableName} with ID: ${model.id}');
    print("data : ${model.toMap()}");
    // Check if the table exists

    await createTable(model);

    return await db.insert(
      model.tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> queryAll<T extends CommonModel>(
    T model,
  ) async {
    final db = await database;

    await createTable(model);

    return await db.query(model.tableName);
  }

  Future<int> update<T extends CommonModel>(T model) async {
    final db = await database;

    await createTable(model);

    return await db.update(
      model.tableName,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<int> delete<T extends CommonModel>(T model, int id) async {
    final db = await database;

    await createTable(model);

    return await db.delete(model.tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<T>> fetchAll<T extends CommonModel>(T model) async {
    final db = await database;

    await createTable(model);

    final List<Map<String, dynamic>> maps = await db.query(model.tableName);

    print('Fetched ${maps}');

    return List.generate(maps.length, (i) {
      return model.fromMap(maps[i]) as T;
    });
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
