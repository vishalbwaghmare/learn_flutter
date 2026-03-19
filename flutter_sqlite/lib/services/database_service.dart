import 'package:flutter_sqlite/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  // Table & Columns
  final String _taskTableName = "task";
  final String _taskIdColumn = "id";
  final String _taskContentColumn = "content";
  final String _taskStatusColumn = "status";

  // DB Getter
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  // Init DB
  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), "my_db.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_taskTableName(
            $_taskIdColumn INTEGER PRIMARY KEY AUTOINCREMENT,
            $_taskContentColumn TEXT NOT NULL,
            $_taskStatusColumn INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // INSERT
  Future<int> addTask(String content) async {
    final db = await database;

    return await db.insert(
      _taskTableName,
      {
        _taskContentColumn: content,
        _taskStatusColumn: 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // READ
  Future<List<Task>> getTasks() async {
    final db = await database;

    final data = await db.query(_taskTableName);

    return data.map((e) => Task.fromMap(e)).toList();
  }

  // UPDATE
  Future<int> updateTaskStatus(int id, int status) async {
    final db = await database;

    return await db.update(
      _taskTableName,
      {_taskStatusColumn: status},
      where: '$_taskIdColumn = ?',
      whereArgs: [id],
    );
  }

  // DELETE
  Future<int> deleteTask(int id) async {
    final db = await database;

    return await db.delete(
      _taskTableName,
      where: '$_taskIdColumn = ?',
      whereArgs: [id],
    );
  }
}
