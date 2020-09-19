import 'package:fiap_trabalho_flutter/data/model/TablesTO.dart';
import 'package:fiap_trabalho_flutter/data/model/Task.dart';
import 'package:fiap_trabalho_flutter/data/model/TaskTO.dart';
import 'package:sqflite/sqflite.dart';

class TaskDAO {

  static Future<int> insert(Task task, Database db) async {

    return await db.insert(
        TablesTO.taskTable,
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  static Future<List<Task>> tasks(Database db) async {

    final List<Map<String, dynamic>> maps = await db.query(TablesTO.taskTable);
    return List.generate(maps.length, (index) {
      return Task(
          maps[index][TaskTO.id],
          maps[index][TaskTO.title],
          maps[index][TaskTO.description],
          maps[index][TaskTO.dateCreated],
          maps[index][TaskTO.todoDate],
          maps[index][TaskTO.lastUpdateDate],
          maps[index][TaskTO.status]
      );
    });
  }

  static Future<int> update(Task task, Database db) async {

    return await db.update(
        TablesTO.taskTable,
        task.toMap(),
        where: "${TaskTO.id} = ?",
        whereArgs: [task.id]
    );
  }

  static Future<int> delete(Task task, Database db) async {

    return await db.delete(
      TablesTO.taskTable,
      where: "${TaskTO.id} = ?",
      whereArgs: [task.id]
    );
  }

}