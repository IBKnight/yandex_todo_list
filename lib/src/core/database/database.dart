import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yandex_todo_list/src/features/todos_list/data/models/todo_item/todo_model.dart';

class DbService {
  static final DbService _instance = DbService._internal();
  factory DbService() => _instance;
  DbService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos(
        id TEXT PRIMARY KEY,
        text TEXT,
        importance TEXT,
        deadline INTEGER,
        done INTEGER,
        color TEXT,
        created_at INTEGER,
        changed_at INTEGER,
        last_updated_by TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE metadata(
        key TEXT PRIMARY KEY,
        value INTEGER
      )
    ''');

    await db.insert('metadata', {'key': 'revision', 'value': 0});
  }

  Future<void> insertTodoModel(TodoModel todo) async {
    final db = await database;
    final Map<String, Object?> todoMap = todo.toJson();
    todoMap['done'] = todo.done ? 1 : 0; // Convert boolean to integer
    await db.insert(
      'todos',
      todoMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TodoModel>> todos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('todos');

    return maps.map((map) {
      final modifiedMap = {
        ...map,
        'done': map['done'] == 1,
      };
      return TodoModel.fromJson(modifiedMap);
    }).toList();
  }

  Future<void> updateTodoModel(TodoModel todo) async {
    final db = await database;
    await db.update(
      'todos',
      todo.toJson(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> clearTodos() async {
    final db = await database;
    await db.delete('todos');
  }

  Future<void> deleteTodoModel(String id) async {
    final db = await database;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getRevision() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'metadata',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: ['revision'],
    );
    if (result.isNotEmpty) {
      return result.first['value'] as int;
    } else {
      return 0;
    }
  }

  Future<void> setRevision(int revision) async {
    final db = await database;
    await db.update(
      'metadata',
      {'value': revision},
      where: 'key = ?',
      whereArgs: ['revision'],
    );
  }

  Future<void> updateDatabase(Map<String, dynamic> data) async {
    if (!data.containsKey('list') || !data.containsKey('revision')) {
      throw ArgumentError('Invalid data format');
    }

    final List<dynamic> list = data['list'];
    final int revision = data['revision'];

    // Clear the current todos
    await clearTodos();

    // Insert the new todos
    for (var item in list) {
      final todo = TodoModel.fromJson(item);

      await insertTodoModel(todo);
    }

    // Update the revision
    await setRevision(revision);
  }
}
