import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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
      readOnly: false,
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
        files TEXT,
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
        return {};
      }

      final Map<String, Object?> todoItem = result.first;

      final Map<String, Object?> map = Map<String, Object?>.from(todoItem);

      if (map.containsKey('done')) {
        map['done'] = map['done'] == 1 ? true : false;
      }

      return map;
    } catch (e) {
      logger.error(e);
      rethrow;
    }
  }

  @override
  Future<Map<String, Object?>> addTodo(Map<String, Object?> todo) async {
    try {
      final db = await database;

      todo['done'] = (todo['done'] == true) ? 1 : 0;

      await db.insert(
        'todos',
        todo,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      int revision = await getRevision();
      await setRevision(revision + 1);

      todo['done'] = todo['done'] == 1;

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

  @override
  Future<Map<String, Object?>> updateTodo(Map<String, Object?> todo) async {
    try {
      final db = await database;
      await db.update(
        'todos',
        todo,
        where: 'id = ?',
        whereArgs: [todo['id']],
      );

      int revision = await getRevision();
      await setRevision(revision + 1);

      return todo;
    } catch (e) {
      logger.error(e);
      rethrow;
    }
  }

  Future<void> _clearTodos() async {
    try {
      final db = await database;
      final int count = await db.delete('todos');
      if (count == 0) {
        logger.warning('No rows were deleted from the todos table.');
      } else {
        logger.info('$count rows were deleted from the todos table.');
      }
    } catch (e) {
      logger.error('Error while clearing todos table: $e');
      rethrow;
    }
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

      int revision = await getRevision();
      await setRevision(revision + 1);

      return todo;
    } catch (e, stackTrace) {
      logger.error(e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
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

  @override
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

  @override
  Future<Map<String, Object?>> updateTodoList(
    Map<String, Object?> newTodoList,
  ) async {
    try {
      if (!newTodoList.containsKey('list') ||
          !newTodoList.containsKey('revision')) {
        throw ArgumentError('Invalid data format');
      }

      final todoList = newTodoList['list'];

      if (todoList is! List<dynamic>) {
        throw ArgumentError('Invalid type for list');
      }
      if (newTodoList['revision'] is! int) {
        throw ArgumentError('Invalid type for revision');
      }

      final List<Map<String, Object?>> list =
          List<Map<String, Object?>>.from(todoList);
      final int revision = newTodoList['revision'] as int;

      // Очистка текущих задач
      await _clearTodos();

      // Вставка новых задач
      for (Map<String, Object?> item in list) {
        await addTodo(item);
      }

      await setRevision(revision);

      return newTodoList;
    } catch (e) {
      logger.error(e);
      rethrow;
    }
  }
}
