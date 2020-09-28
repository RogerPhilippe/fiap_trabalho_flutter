// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemModel on _ItemModelBase, Store {
  final _$titleAtom = Atom(name: '_ItemModelBase.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$descriptionAtom = Atom(name: '_ItemModelBase.description');

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

  final _$checkAtom = Atom(name: '_ItemModelBase.check');

  @override
  bool get check {
    _$checkAtom.reportRead();
    return super.check;
  }

  @override
  set check(bool value) {
    _$checkAtom.reportWrite(value, super.check, () {
      super.check = value;
    });
  }

  final _$_ItemModelBaseActionController =
      ActionController(name: '_ItemModelBase');

  @override
  dynamic setTitle(String value) {
    final _$actionInfo = _$_ItemModelBaseActionController.startAction(
        name: '_ItemModelBase.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_ItemModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDescription(String value) {
    final _$actionInfo = _$_ItemModelBaseActionController.startAction(
        name: '_ItemModelBase.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_ItemModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTask(bool value) {
    final _$actionInfo = _$_ItemModelBaseActionController.startAction(
        name: '_ItemModelBase.setTask');
    try {
      return super.setTask(value);
    } finally {
      _$_ItemModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
description: ${description},
check: ${check}
    ''';
  }
}
