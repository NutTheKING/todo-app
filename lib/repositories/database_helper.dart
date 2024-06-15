import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/dto/todo_list_dto.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Todo.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
        "CREATE TABLE Todo(id INTEGER PRIMARY KEY, title TEXT NOT NULL, created_date TEXT NOT NULL, item TEXT NOT NULL);",
      ),
      version: _version,
    );
  }

  static Future<int> addTodoItem(TodoListDto todos) async {
    final db = await _getDB();
    return await db.insert(
      "Todo",
      todos.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateTodo(TodoListDto todos) async {
    final db = await _getDB();
    return await db.update(
      "Todo",
      todos.toJson(),
      where: "id = ?",
      whereArgs: [todos.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteTodo(TodoListDto todos) async {
    final db = await _getDB();
    return await db.delete(
      "Todo",
      where: "id = ?",
      whereArgs: [todos.id],
    );
  }

  static Future<List<TodoListDto>?> getAllTodoItem() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Todo");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => TodoListDto.fromJson(maps[index]));
  }
}
