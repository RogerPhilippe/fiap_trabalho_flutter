import 'package:fiap_trabalho_flutter/data/model/TablesTO.dart';
import 'package:fiap_trabalho_flutter/data/model/TaskTO.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {

  static Future<Database> getDatabase() async {

    String createTableTasks = "CREATE TABLE IF NOT EXISTS ${TablesTO.taskTable} "
        "("
        "${TaskTO.id} INTEGER PRIMARY KEY AUTOINCREMENT, "
        "${TaskTO.title} TEXT NOT NULL, "
        "${TaskTO.description} TEXT NOT NULL, "
        "${TaskTO.dateCreated} INTEGER NOT NULL, "
        "${TaskTO.todoDate} INTEGER NOT NULL, "
        "${TaskTO.lastUpdateDate} INTEGER NOT NULL, "
        "${TaskTO.status} INTEGER NOT NULL"
        ")";

    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'fiap_tasks.db'),
      onCreate: (db, version) {
        return db.execute(createTableTasks);
      },
      version: 1
    );
    return database;
  }

}