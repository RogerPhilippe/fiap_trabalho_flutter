// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Controller on ControllerBase, Store {
  final _$clicksAtom = Atom(name: 'ControllerBase.clicks');

  @override
  int get clicks {
    _$clicksAtom.reportRead();
    return super.clicks;
  }

  @override
  set clicks(int value) {
    _$clicksAtom.reportWrite(value, super.clicks, () {
      super.clicks = value;
    });
  }

  final _$nameAtom = Atom(name: 'ControllerBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$descriptionAtom = Atom(name: 'ControllerBase.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$dateTodoAtom = Atom(name: 'ControllerBase.dateTodo');

  @override
  int get dateTodo {
    _$dateTodoAtom.reportRead();
    return super.dateTodo;
  }

  @override
  set dateTodo(int value) {
    _$dateTodoAtom.reportWrite(value, super.dateTodo, () {
      super.dateTodo = value;
    });
  }

  final _$taskSavedAtom = Atom(name: 'ControllerBase.taskSaved');

  @override
  bool get taskSaved {
    _$taskSavedAtom.reportRead();
    return super.taskSaved;
  }

  @override
  set taskSaved(bool value) {
    _$taskSavedAtom.reportWrite(value, super.taskSaved, () {
      super.taskSaved = value;
    });
  }

  final _$tasksLoadedAtom = Atom(name: 'ControllerBase.tasksLoaded');

  @override
  bool get tasksLoaded {
    _$tasksLoadedAtom.reportRead();
    return super.tasksLoaded;
  }

  @override
  set tasksLoaded(bool value) {
    _$tasksLoadedAtom.reportWrite(value, super.tasksLoaded, () {
      super.tasksLoaded = value;
    });
  }

  final _$loggedAtom = Atom(name: 'ControllerBase.logged');

  @override
  bool get logged {
    _$loggedAtom.reportRead();
    return super.logged;
  }

  @override
  set logged(bool value) {
    _$loggedAtom.reportWrite(value, super.logged, () {
      super.logged = value;
    });
  }

  final _$itemsAtom = Atom(name: 'ControllerBase.items');

  @override
  ObservableList<Task> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<Task> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  final _$realAtom = Atom(name: 'ControllerBase.real');

  @override
  String get real {
    _$realAtom.reportRead();
    return super.real;
  }

  @override
  set real(String value) {
    _$realAtom.reportWrite(value, super.real, () {
      super.real = value;
    });
  }

  final _$dollarAtom = Atom(name: 'ControllerBase.dollar');

  @override
  String get dollar {
    _$dollarAtom.reportRead();
    return super.dollar;
  }

  @override
  set dollar(String value) {
    _$dollarAtom.reportWrite(value, super.dollar, () {
      super.dollar = value;
    });
  }

  final _$euroAtom = Atom(name: 'ControllerBase.euro');

  @override
  String get euro {
    _$euroAtom.reportRead();
    return super.euro;
  }

  @override
  set euro(String value) {
    _$euroAtom.reportWrite(value, super.euro, () {
      super.euro = value;
    });
  }

  final _$bitCoinAtom = Atom(name: 'ControllerBase.bitCoin');

  @override
  String get bitCoin {
    _$bitCoinAtom.reportRead();
    return super.bitCoin;
  }

  @override
  set bitCoin(String value) {
    _$bitCoinAtom.reportWrite(value, super.bitCoin, () {
      super.bitCoin = value;
    });
  }

  final _$saveTaskAsyncAction = AsyncAction('ControllerBase.saveTask');

  @override
  Future<bool> saveTask() {
    return _$saveTaskAsyncAction.run(() => super.saveTask());
  }

  final _$ControllerBaseActionController =
      ActionController(name: 'ControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String nameValue) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setName');
    try {
      return super.setName(nameValue);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String descriptionValue) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setDescription');
    try {
      return super.setDescription(descriptionValue);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDateTodo(int dateTodoValue) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setDateTodo');
    try {
      return super.setDateTodo(dateTodoValue);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReal(String value) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setReal');
    try {
      return super.setReal(value);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDollar(String value) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setDollar');
    try {
      return super.setDollar(value);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEuro(String value) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setEuro');
    try {
      return super.setEuro(value);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBitCoin(String value) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setBitCoin');
    try {
      return super.setBitCoin(value);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadTaskList() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.loadTaskList');
    try {
      return super.loadTaskList();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setItemCheckStatus(bool status, int index) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setItemCheckStatus');
    try {
      return super.setItemCheckStatus(status, index);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeList(int index) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.removeList');
    try {
      return super.removeList(index);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cancelLastItemRemoved(int index) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.cancelLastItemRemoved');
    try {
      return super.cancelLastItemRemoved(index);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void firebaseLogin(UserSession userSession) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.firebaseLogin');
    try {
      return super.firebaseLogin(userSession);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveFirebaseUser(User user, UserSession userSession) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.saveFirebaseUser');
    try {
      return super.saveFirebaseUser(user, userSession);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveTaskFirebase(BuildContext context, UserSession userSession) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.saveTaskFirebase');
    try {
      return super.saveTaskFirebase(context, userSession);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getTasks(BuildContext context, UserSession userSession) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.getTasks');
    try {
      return super.getTasks(context, userSession);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTasks(BuildContext context, UserSession userSession) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.removeTasks');
    try {
      return super.removeTasks(context, userSession);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeUser(BuildContext context, UserSession userSession) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.removeUser');
    try {
      return super.removeUser(context, userSession);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void exchangeService(String value) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.exchangeService');
    try {
      return super.exchangeService(value);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
clicks: ${clicks},
name: ${name},
description: ${description},
dateTodo: ${dateTodo},
taskSaved: ${taskSaved},
tasksLoaded: ${tasksLoaded},
logged: ${logged},
items: ${items},
real: ${real},
dollar: ${dollar},
euro: ${euro},
bitCoin: ${bitCoin}
    ''';
  }
}
