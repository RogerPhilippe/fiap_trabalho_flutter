import 'package:mobx/mobx.dart';

part 'ItemModel.g.dart';

class ItemModel = _ItemModelBase with _$ItemModel;

abstract class _ItemModelBase with Store {

  _ItemModelBase(this.title, this.description, this.check);

  @observable
  String title;
  @observable
  String description;
  @observable
  bool check;

  @action
  setTitle(String value) => title = value;
  @action
  setDescription(String value) => description = value;
  @action
  setTask(bool value) => check = value;

}