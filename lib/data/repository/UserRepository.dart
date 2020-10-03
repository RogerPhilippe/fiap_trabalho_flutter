import 'package:fiap_trabalho_flutter/data/dao/UserDAO.dart';
import 'package:fiap_trabalho_flutter/data/model/User.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {

  static Future<int> insert(User user, Database db) async {
    return await UserDAO.insert(user, db);
  }

  static Future<List<User>> findAll(Database db) async {
    return await UserDAO.findAll(db);
  }

  static Future<int> delete(User user, Database db) async {
    return await UserDAO.delete(user, db);
  }

  static Future<int> deleteAll(Database db) async {
    return await UserDAO.deleteAll(db);
  }

}