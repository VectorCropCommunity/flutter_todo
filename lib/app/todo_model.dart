import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String tableTodo = 'todo';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnDescription = 'description';
const String columnStatus = 'status';
const String columnDueDate = 'dueDate';
const String columnCreatedAt = 'createdAt';
const String columnCategory = 'category';
const String columnUpdatedAt = 'updatedAt';

class Todo {
  int id = 0;
  String title = '';
  String description = '';
  bool status = false;
  String category = '';
  String dueDate = '';
  String createdAt = '';
  String updatedAt = '';

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnTitle: title,
      columnDescription: description,
      columnStatus: status ? 1 : 0,
      columnDueDate: dueDate,
      columnCategory: category,
      columnCreatedAt: createdAt,
      columnUpdatedAt: updatedAt,
    };
    return map;
  }

  Todo();

  Todo.fromMap(Map<String, Object?> map) {
    id = int.parse("${map[columnId]}");
    title = "${map[columnTitle]}";
    description = "${map[columnDescription]}";
    status = map[columnStatus] == 1 ? true : false;
    dueDate = "${map[columnDueDate]}";
    category = "${map[columnCategory]}";
    createdAt = "${map[columnCreatedAt]}";
    updatedAt = "${map[columnUpdatedAt]}";
  }
}

class TodoProvider {
  late Database db;

  Future open() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    db = await openDatabase("${appDocumentsDir.path}/todo.db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnStatus integer not null,
  $columnCategory text not null,
  $columnCreatedAt text not null,
  $columnUpdatedAt text not null,
  $columnDescription text not null,
  $columnDueDate text not null
  )
''');
    });
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<List<Todo>> getAllTodos() async {
    List<Map<String, Object?>> maps = await db.query(tableTodo);
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  Future<Todo?> getTodo(int id) async {
    List<Map<String, Object?>> maps = await db.query(tableTodo,
        columns: [
          columnId,
          columnStatus,
          columnTitle,
          columnCategory,
          columnCreatedAt,
          columnDescription,
          columnDueDate,
          columnUpdatedAt
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (!maps.length.isNegative) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}
