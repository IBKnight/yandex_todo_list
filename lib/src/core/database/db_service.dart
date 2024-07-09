import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yandex_todo_list/src/core/database/ilocal_storage.dart';
import 'package:yandex_todo_list/src/core/utils/logger.dart';

class DbService implements ILocalStorage {
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

  @override
  Future<Map<String, Object?>> getTodo(String id) async {
    try {
      final db = await database;

      final List<Map<String, Object?>> result = await db.query(
        'todos',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isEmpty) {
        return {}; // Возвращаем пустую карту, если задача не найдена
      }

      final Map<String, Object?> todoItem = result.first;

      if (todoItem.containsKey('done')) {
        todoItem['done'] = todoItem['done'] == 1 ? true : false;
      }

      return todoItem;
    } catch (e) {
      logger.error(e);
      rethrow;
    }
  }

  @override
  Future<Map<String, Object?>> addTodo(Map<String, Object?> todo) async {
    try {
      final db = await database;

      todo['done'] = (todo['done'] == 'true') ? 1 : 0;
      await db.insert(
        'todos',
        todo,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return todo;
    } catch (e) {
      logger.error(e);
      rethrow;
    }
  }

  @override
  Future<Map<String, Object?>> getTodoList() async {
    try {
      final db = await database;

      final List<Map<String, Object?>> maps = await db.query('todos');

      final todoList = maps.map((map) {
        final modifiedMap = {
          ...map,
          'done': map['done'] == 1,
        };

        return modifiedMap;
      }).toList();

      int revision = await getRevision();

      final Map<String, Object?> result = {
        'status': 'ok',
        'list': todoList,
        'revision': revision,
      };

      return result;
    } catch (e) {
      logger.error(e);
      rethrow;
    }
  }

  Future<Map<String, Object?>> updateTodo(Map<String, Object?> todo) async {
    try {
      final db = await database;
      await db.update(
        'todos',
        todo,
        where: 'id = ?',
        whereArgs: [todo['id']],
      );

      return todo;
    } catch (e) {
      logger.error(e);
      rethrow;
    }
  }

  Future<void> clearTodos() async {
    final db = await database;
    await db.delete('todos');
  }

  @override
  Future<Map<String, Object?>> deleteTodo(String id) async {
    try {
      final db = await database;

      final todo = await getTodo(id);

      if (todo.isEmpty) {
        throw Exception('Element with id = $id does not exist ');
      }

      await db.delete(
        'todos',
        where: 'id = ?',
        whereArgs: [id],
      );

      return todo;
    } catch (e) {
      logger.error(e);
      rethrow;
    }
  }

  Future<int> getRevision() async {
    try {
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
    } catch (e) {
      logger.error(e);
      rethrow;
    }
  }

  Future<void> setRevision(int revision) async {
    try {
      final db = await database;
      await db.update(
        'metadata',
        {'value': revision},
        where: 'key = ?',
        whereArgs: ['revision'],
      );
    } catch (e) {
      logger.error(e);
      rethrow;
    }
  }

  Future<void> updateTodoList(Map<String, dynamic> data) async {
    try {
      if (!data.containsKey('list') || !data.containsKey('revision')) {
        throw ArgumentError('Invalid data format');
      }

      final List<dynamic> list = data['list'];
      final int revision = data['revision'];

      // Clear the current todos
      await clearTodos();

      // Insert the new todos
      for (var item in list) {
        await addTodo(item);
      }

      // Update the revision
      await setRevision(revision);
    } catch (e) {
      logger.error(e);
      rethrow;
    }
  }
}
