import 'package:fiap_trabalho_flutter/data/model/Task.dart';
import 'package:fiap_trabalho_flutter/data/repository/TaskRepository.dart';
import 'package:fiap_trabalho_flutter/data/repository/UserRepository.dart';
import 'package:fiap_trabalho_flutter/data/service/LogUtils.dart';
import 'package:fiap_trabalho_flutter/data/utils/UserSession.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';

import '../DatabaseHandler.dart';

part 'Controller.g.dart';

class Controller = ControllerBase with _$Controller;

abstract class ControllerBase with Store {

  // C:\DevEnv\Tools\flutter\bin\flutter pub run build_runner build

  @observable
  int clicks = 0;
  @observable
  String name = "";
  @observable
  String description = "";
  @observable
  int dateTodo = 0;
  @observable
  bool taskSaved = false;
  @observable
  bool tasksLoaded = false;
  @observable
  bool logged = false;
  @observable
  ObservableList<Task> items = ObservableList<Task>();
  List<Task> updateListTask = [];
  List<Task> removedTaskList = [];

  @action
  void increment() {
    clicks++;
  }
  @action
  void setName(String nameValue) {
    name = nameValue;
  }
  @action
  void setDescription(String descriptionValue) {
    description = descriptionValue;
  }
  @action
  void setDateTodo(int dateTodoValue) {
    dateTodo = dateTodoValue;
  }

  @action
  Future<bool> saveTask() async {
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    var dateCreated = DateTime.now().millisecondsSinceEpoch;
    var dateLastUpdate = DateTime.now().millisecondsSinceEpoch;
    final task = new Task(id, name, description, dateCreated, dateTodo, dateLastUpdate, 0);
    return await _saveTask(task);
  }

  Future<bool> _saveTask(Task task) async {

    Database db = await DatabaseHandler.getDatabase();

    if (db != null) {
      int result = await TaskRepository.insert(task, db);
      if (result == null || result < 0) {
        LogUtils.error('Erro ao tentar salvar');
        return false;
      } else {
        LogUtils.info("Task salva!");
        return true;
      }
    } else {
      LogUtils.error('Erro ao abrir banco de dados!');
      return false;
    }

  }

  @action
  void loadTaskList() {

    DatabaseHandler.getDatabase().then((db) {
      TaskRepository.tasks(db).then((taskList) {
        if (taskList != null) {
          items.clear();
          items.addAll(taskList);
        }
        tasksLoaded = true;
      }).catchError((onError) => LogUtils.error('Erro ao buscar tarefas!'));
    }).catchError((onError) => LogUtils.error('Erro ao abrir banco de dados!'));
  }

  @action
  void setItemCheckStatus(bool status, int index) {

    var task = items[index];
    task.status = status ? 1 : 0;
    updateListTask.add(task);
    items.removeAt(index);
    items.insert(index, task);
  }

  @action
  void dispose() {

    if (removedTaskList.isNotEmpty)
      _deleteTask(removedTaskList);
    if (updateListTask.isNotEmpty)
      _updateTask(updateListTask);
    _cleanVariables();
  }

  void _cleanVariables() {

    clicks = 0;
    name = "";
    description = "";
    dateTodo = 0;
    taskSaved = false;
    tasksLoaded = false;
    items = ObservableList<Task>();
    updateListTask = [];
    removedTaskList = [];
  }

  @action
  void removeList(int index) {
    removedTaskList.add(items[index]);
    items.removeAt(index);
  }

  @action
  void cancelLastItemRemoved(int index) {
    var task = removedTaskList.last;
    removedTaskList.removeLast();
    items.insert(index, task);
  }

  void _deleteTask(List<Task> tasks) {

    DatabaseHandler.getDatabase().then((db) {
      tasks.forEach((task) {
        TaskRepository.delete(task, db).then((value) => LogUtils.info("Task Removed!"));
      });
    });
  }

  void _updateTask(List<Task> tasks) {
    DatabaseHandler.getDatabase().then((db) {
      tasks.forEach((task) {
        TaskRepository.update(task, db).then((value) => LogUtils.info("Task Updated!"));
      });
    });
  }

  @action
  void firebaseLogin(UserSession userSession) {

    final auth = FirebaseAuth.instance;

    auth.currentUser()
        .then((firebaseUser) {
      if (firebaseUser == null || firebaseUser.uid == null || firebaseUser.uid.isEmpty)
        _loginFirebase(auth, userSession);
      else {
        userSession.userToken = firebaseUser.uid;
        LogUtils.info("Logado no firebase!");
      }
    }).catchError((onError) => _loginFirebase(auth, userSession));

    DatabaseHandler.getDatabase().then((db) {
      UserRepository.findAll(db).then((users) {
        userSession.userID = users[0].id;
        userSession.name = users[0].name;
        userSession.email = users[0].email;

        logged = true;
      }).catchError((onError) {
        LogUtils.error('Error find user.');
        logged = false;
      });
    }).catchError((onError) {
      LogUtils.error('Error try open db.');
      logged = false;
    });
  }

  void _loginFirebase(FirebaseAuth auth, UserSession userSession) {

    LogUtils.info('Fazendo login no firebase.');

    auth.signInWithEmailAndPassword(email: "system_user@email.com", password: "syste@2020")
        .then((firebaseUser) => userSession.userToken = firebaseUser.uid)
        .catchError((onError) => LogUtils.error('Erro ao fazer login firebase.'));
  }

}