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
  String get dateTodo {
    _$dateTodoAtom.reportRead();
    return super.dateTodo;
  }

  @override
  set dateTodo(String value) {
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
  void setDateTodo(String dateTodoValue) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setDateTodo');
    try {
      return super.setDateTodo(dateTodoValue);
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
taskSaved: ${taskSaved}
    ''';
  }
}
