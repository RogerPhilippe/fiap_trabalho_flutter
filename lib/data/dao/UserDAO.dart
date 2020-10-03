import 'package:fiap_trabalho_flutter/data/model/TablesTO.dart';
import 'package:fiap_trabalho_flutter/data/model/User.dart';
import 'package:fiap_trabalho_flutter/data/model/UserTO.dart';
import 'package:sqflite/sqflite.dart';

class UserDAO {

  static Future<int> insert(User user, Database db) async {

    return await db.insert(
        TablesTO.userTable,
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  static Future<List<User>> findAll(Database db) async {

    final List<Map<String, dynamic>> maps = await db.query(TablesTO.userTable);
    return List.generate(maps.length, (index) {
      return User(
          maps[index][UserTO.id],
          maps[index][UserTO.name],
          maps[index][UserTO.email]
      );
    });
  }

  static Future<int> delete(User user, Database db) async {

    return await db.delete(
      TablesTO.userTable,
      where: "${UserTO.id} = ?",
      whereArgs: [user.id]
    );
  }

  static Future<int> deleteAll(Database db) async {

    return await db.delete(TablesTO.userTable);
  }

}