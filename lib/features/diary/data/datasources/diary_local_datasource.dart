import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/diary_entry_model.dart';

abstract class DiaryLocalDatasource {
  Future<List<DiaryEntryModel>> getAllEntries();
  Future<DiaryEntryModel> insertEntry(DiaryEntryModel model);
  Future<void> deleteEntry(int id);
}

class DiaryLocalDatasourceImpl implements DiaryLocalDatasource {
  static const _dbName = 'agenda_diario.db';
  static const _dbVersion = 1;
  static const _tableName = 'diary_entries';

  Database? _db;

  Future<Database> get _database async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE INDEX idx_diary_entries_created_at
          ON $_tableName(created_at DESC)
        ''');
      },
    );
  }

  @override
  Future<List<DiaryEntryModel>> getAllEntries() async {
    final db = await _database;
    final rows = await db.query(
      _tableName,
      orderBy: 'created_at DESC',
    );
    return rows.map(DiaryEntryModel.fromMap).toList();
  }

  @override
  Future<DiaryEntryModel> insertEntry(DiaryEntryModel model) async {
    final db = await _database;
    final id = await db.insert(
      _tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return DiaryEntryModel(
      id: id,
      title: model.title,
      content: model.content,
      createdAt: model.createdAt,
    );
  }

  @override
  Future<void> deleteEntry(int id) async {
    final db = await _database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
