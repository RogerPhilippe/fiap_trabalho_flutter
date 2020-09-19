import 'package:fiap_trabalho_flutter/data/dao/TaskDAO.dart';
import 'package:fiap_trabalho_flutter/data/model/Task.dart';
import 'package:sqflite/sqflite.dart';

class TaskRepository {

  static Future<int> insert(Task task, Database db) async {
    return await TaskDAO.insert(task, db);
  }

  static Future<List<Task>> tasks(Database db) async {
    return await TaskDAO.tasks(db);
  }

  static Future<int> update(Task task, Database db) async {
    return await TaskDAO.update(task, db);
  }

  static Future<int> delete(Task task, Database db) async {
    return await TaskDAO.delete(task, db);
  }

}