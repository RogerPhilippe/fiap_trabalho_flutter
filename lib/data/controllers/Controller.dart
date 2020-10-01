import 'package:fiap_trabalho_flutter/data/model/Task.dart';
import 'package:fiap_trabalho_flutter/data/repository/TaskRepository.dart';
import 'package:fiap_trabalho_flutter/data/service/LogUtils.dart';
import 'package:mobx/mobx.dart';

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
  String dateTodo = "";
  @observable
  bool taskSaved = false;
  @observable
  bool tasksLoaded = false;
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
  void setDateTodo(String dateTodoValue) {
    dateTodo = dateTodoValue;
  }

  @action
  void saveTask() {
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    var dateCreated = DateTime.now().millisecondsSinceEpoch;
    var dateLastUpdate = DateTime.now().millisecondsSinceEpoch;
    final task = new Task(id, name, description, dateCreated, 0, dateLastUpdate, 0);
    _saveTask(task);
  }

  void _saveTask(Task task) {

    DatabaseHandler.getDatabase().then((db) {
      TaskRepository.insert(task, db).then((value) {
        LogUtils.info("Task salva!");
      }).catchError((onError) {
        LogUtils.error('Erro ao tentar salvar');
        LogUtils.error(onError);
      });
    }).catchError((onError) => LogUtils.error('Erro ao abrir banco de dados!'));

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
    dateTodo = "";
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

}