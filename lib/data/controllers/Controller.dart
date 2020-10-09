import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiap_trabalho_flutter/data/model/Task.dart';
import 'package:fiap_trabalho_flutter/data/model/User.dart';
import 'package:fiap_trabalho_flutter/data/repository/TaskRepository.dart';
import 'package:fiap_trabalho_flutter/data/repository/UserRepository.dart';
import 'package:fiap_trabalho_flutter/data/service/FirebaseService.dart';
import 'package:fiap_trabalho_flutter/data/service/LogUtils.dart';
import 'package:fiap_trabalho_flutter/data/service/RequestHttpService.dart';
import 'package:fiap_trabalho_flutter/data/utils/UserSession.dart';
import 'package:fiap_trabalho_flutter/screens/utils/DialogUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @observable
  String dollarToReal;
  @observable
  String euroToReal;
  @observable
  String btcToReal;
  @observable
  String dollar;
  @observable
  String euro;
  @observable
  String bitCoin;
  String dollarToRealUnObservable;
  String euroToRealUnObservable;
  String btcToRealUnObservable;
  String dollarUnObservable;
  String euroUnObservable;
  String bitCoinUnObservable;
  @observable
  ObservableList<String> mUFList = ObservableList<String>();
  @observable
  ObservableList<String> mCities = ObservableList<String>();
  String cep;
  @observable
  String address = "";
  @observable
  String mUF;
  @observable
  String mCity;
  @observable
  String cepBySearch = "";
  String mStreet;

  @action
  void increment() { clicks++; }

  @action
  void setName(String nameValue) { name = nameValue; }

  @action
  void setDescription(String descriptionValue) { description = descriptionValue; }

  @action
  void setDateTodo(int dateTodoValue) { dateTodo = dateTodoValue; }

  @action
  void setDollarToReal(String value) { dollarToRealUnObservable = value; }

  @action
  void setEuroToReal(String value) { euroToRealUnObservable = value; }

  @action
  void setBtcToReal(String value) { btcToRealUnObservable = value; }

  @action
  void setUF(String value) {
    this.mUF = value;
    this.getCities();
  }

  @action
  void setCity(String value) { this.mCity = value; }

  @action
  void setDollar(String value) {
    dollarUnObservable = value;
    if (value.isEmpty) {
      dollarToReal = "";
      dollarToRealUnObservable = "";
    }
  }

  @action
  void setEuro(String value) {
    euroUnObservable = value;
    if (value.isEmpty) {
      euroToReal = "";
      euroToRealUnObservable = "";
    }
  }
  @action
  void setBitCoin(String value) {
    bitCoinUnObservable = value;
    if (value.isEmpty) {
      btcToReal = "";
      btcToRealUnObservable = "";
    }
  }

  @action
  void setCep(String value) { this.cep = value; }

  @action
  void setStreet(String value) { this.mStreet = value; }

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
        logged = true;
      });
    }).catchError((onError) {
      LogUtils.error('Error try open db.');
      logged = true;
    });
  }

  void _loginFirebase(FirebaseAuth auth, UserSession userSession) {

    LogUtils.info('Fazendo login no firebase.');

    auth.signInWithEmailAndPassword(email: "system_user@email.com", password: "syste@2020")
        .then((firebaseUser) => userSession.userToken = firebaseUser.uid)
        .catchError((onError) => LogUtils.error('Erro ao fazer login firebase.'));
  }

  @action
  void saveFirebaseUser(User user, UserSession userSession) {

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    FirebaseService.findUserFirestore(user, firestore).then((documentSnapshot) {
      if (documentSnapshot != null && documentSnapshot.docs.isNotEmpty) {

        var doc = documentSnapshot.docs[0];
        var data = doc.data();
        LogUtils.info('Usuário já cadastrado na nuvem: ${data["userEmail"]}');
        _saveUser(user, userSession);

      } else {

        LogUtils.info('Usuário não existe na nuvem.');

        FirebaseService.saveFireStore(user, firestore)
            .then((value) {
          LogUtils.info('User saved in Firebase');
          _saveUser(user, userSession);
        })
            .catchError((onError) {
          LogUtils.error('Erro ao tentar salvar no firebase!');
        });
      }
    }).catchError((onError) => LogUtils.error('Erro ao buscar usuário na nuvem.'));

  }

  void _saveUser(User user, UserSession userSession) {

    DatabaseHandler.getDatabase().then((db) => {
      UserRepository.insert(user, db).then((value) {
        LogUtils.info('User saved local db!');
        userSession.userID = user.id;
        userSession.name = user.name;
        userSession.email = user.email;
      })
          .catchError((onError, error) {
        LogUtils.error('Error try save user!');
        LogUtils.error(onError);
        LogUtils.error(error);
      })
    }).catchError((onError) => LogUtils.error('Erro ao tentar abrir banco!'));
  }

  @action
  void saveTaskFirebase(BuildContext context, UserSession userSession) {

    DatabaseHandler.getDatabase().then((db) {
      TaskRepository.tasks(db).then((taskList) async {

        if (taskList != null) {

          FirebaseFirestore firestore = FirebaseFirestore.instance;
          await FirebaseService.removeTasks(userSession, firestore);
          await FirebaseService.saveTasks(userSession, taskList, firestore);
          DialogUtils.makeOkDialog(context, "Tarefas salvas na nuvem.");
        }

      }).catchError((onError) => LogUtils.error('Erro ao buscar tarefas!'));
    }).catchError((onError) => LogUtils.error('Erro ao abrir banco de dados!'));

  }

  @action
  void getTasks(BuildContext context, UserSession userSession) {

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DatabaseHandler.getDatabase().then((db) async {

      await TaskRepository.deleteAll(db);

      FirebaseService.getTasks(userSession, firestore).then((documentSnapshot) {

        if (documentSnapshot != null && documentSnapshot.docs.isNotEmpty) {
          documentSnapshot.docs.forEach((doc) async {
            var task = Task(
                doc["taskID"],
                doc["taskTitle"],
                doc["taskDescription"],
                doc["taskDateCreated"],
                doc["todoDate"],
                doc["lastUpdateDate"],
                doc["status"]
            );
            await TaskRepository.insert(task, db);
          });

          DialogUtils.makeOkDialog(context, "Tarefas baixadas.");

        }
      });

    });

  }

  @action
  void removeTasks(BuildContext context, UserSession userSession) {

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseService.removeTasks(userSession, firestore);

    DatabaseHandler.getDatabase().then((db) async {
      int rowsAffected = await TaskRepository.deleteAll(db);

      if (rowsAffected > 0)
        DialogUtils.makeOkDialog(context, "Tarefas excluidas.");

    });
  }

  @action
  void removeUser(BuildContext context, UserSession userSession) {

    DatabaseHandler.getDatabase().then((db) async {
      await UserRepository.deleteAll(db);
      await TaskRepository.deleteAll(db);

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseService.removeTasks(userSession, firestore);
      FirebaseService.removeUser(userSession, firestore);

      userSession.clearUser();

    });
  }

  @action
  void exchangeService(String value) {

    RequestHttpService.requestExchangesGet().then((response) {
      if (response != null && response.statusCode == 200 &&
          response.body != null && response.body.isNotEmpty) {

        var usd = json.decoder.convert(response.body)["USD"];
        var eur = json.decoder.convert(response.body)["EUR"];
        var btc = json.decoder.convert(response.body)["BTC"];

        if (value == "dollar") {
          if (dollarToRealUnObservable != null && dollarToRealUnObservable.isNotEmpty) {
            var realDouble = double.tryParse(dollarToRealUnObservable);
            var dollarDouble = realDouble / double.tryParse(usd["high"]);
            dollar = dollarDouble.toString();
            dollarUnObservable = dollarDouble.toString();
          }
          else if (dollarUnObservable != null && dollarUnObservable.isNotEmpty) {
            var realDouble = double.tryParse(usd["high"]) * double.tryParse(dollarUnObservable);
            dollarToReal = realDouble.toString();
            dollarToRealUnObservable = realDouble.toString();
          }
        }

        if (value == "euro") {
          if (euroToRealUnObservable != null && euroToRealUnObservable.isNotEmpty) {
            var realDouble = double.tryParse(euroToRealUnObservable);
            var euroDouble = realDouble / double.tryParse(eur["high"]);
            euro = euroDouble.toString();
            euroUnObservable = euroDouble.toString();
          }
          else if (euroUnObservable != null && euroUnObservable.isNotEmpty) {
            var realDouble = double.tryParse(eur["high"]) * double.tryParse(euroUnObservable);
            euroToReal = realDouble.toString();
            euroToRealUnObservable = realDouble.toString();
          }
        }

        if (value == "btc") {
          if (btcToRealUnObservable != null && btcToRealUnObservable.isNotEmpty) {
            var realDouble = double.tryParse(btcToRealUnObservable);
            var btcDouble = realDouble / double.tryParse(btc["high"]);
            bitCoin = btcDouble.toString();
            bitCoinUnObservable = btcDouble.toString();
          }
          else if (bitCoinUnObservable != null && bitCoinUnObservable.isNotEmpty) {
            var realDouble = double.tryParse(btc["high"]) * double.tryParse(bitCoinUnObservable);
            btcToReal = realDouble.toString();
            btcToRealUnObservable = realDouble.toString();
          }
        }
      }
    });
  }

  @action
  void searchAddressByCep() {

    RequestHttpService.searchAddressByCep(cep).then((addressResponse) {

      if (addressResponse != null && addressResponse.statusCode == 200 &&
          addressResponse.body != null && addressResponse.body.isNotEmpty) {
        var jsonAddress = json.decoder.convert(addressResponse.body);
        address = "${jsonAddress["logradouro"]}, ${jsonAddress["complemento"]} - "
            "${jsonAddress["bairro"]} - ${jsonAddress["localidade"]} - "
            "${jsonAddress["uf"]}";
      } else
        address = "";

    });

  }

  @action
  void getUFs() {

    RequestHttpService.requestUFs().then((ufList) {

      if (ufList != null && ufList.statusCode == 200 && ufList.body != null &&
          ufList.body.isNotEmpty) {

        var ufs = json.decoder.convert(ufList.body);
        ufs.forEach((uf) {
          mUFList.add(uf["sigla"]);
        });

      }
    });
  }

  @action
  void getCities() {

    RequestHttpService.requestCitiesByState(mUF).then((citiesResponse) {

      if (citiesResponse != null && citiesResponse.statusCode == 200 &&
          citiesResponse.body != null && citiesResponse.body.isNotEmpty) {

        var citiesJson = json.decoder.convert(citiesResponse.body);
        citiesJson.forEach((city) {
          mCities.add(city["nome"]);
        });

      }
    });
  }

  @action
  void searchCepByAddress() {

    RequestHttpService.searchCepByAddress(mUF, mCity, mStreet).then((addressResponse) {

      if (addressResponse != null && addressResponse.statusCode == 200 &&
      addressResponse.body != null && addressResponse.body.isNotEmpty) {

        var addresses = json.decoder.convert(addressResponse.body);
        if (addresses != null && addresses.isNotEmpty) {
          var addressJson = addresses[0];
          cepBySearch = "CEP: ${addressJson["cep"]} - Bairro: ${addressJson["bairro"]}";
        } else
          cepBySearch = "Nada encontrado!";
      }
    });
  }


}