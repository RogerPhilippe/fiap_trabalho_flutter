import 'package:fiap_trabalho_flutter/data/DatabaseHandler.dart';
import 'package:fiap_trabalho_flutter/data/model/User.dart';
import 'package:fiap_trabalho_flutter/data/repository/UserRepository.dart';
import 'package:fiap_trabalho_flutter/data/utils/UserSession.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }

}

class _SettingsState extends State<Settings> with WidgetsBindingObserver {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _textFieldNameController = TextEditingController();
  final _textFieldEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: appDarkGreyColor,
        body: _buildBody()
    );
  }

  // Body
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    return SafeArea(
        child: Column(
            children: <Widget> [
              Container(
                  padding: EdgeInsets.fromLTRB(16, 28, 16, 28),
                  child: Row(
                      children: [
                        GestureDetector(
                          child: Icon(Icons.arrow_back, size: 28, color:  Colors.orange),
                          onTap: () => { Navigator.of(context).pop() },
                        ),
                        SizedBox(width: 24),
                        Center(
                            child: _buildDefaultText("Configurações", 24)
                        )
                      ]
                  )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                height: 90.0,
                width: double.infinity,
                child: _buildDefaultBtn("CADASTRAR EMAIL", () {
                  if (UserSession.name.isEmpty)
                    _saveUserDialog(context);
                  else {
                    _buildDialog(
                        context,
                      "Usuário já cadastrado",
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildDefaultText(UserSession.name, 16),
                            _buildDefaultText(UserSession.email, 16)
                          ],
                        )
                    );
                    print('User exists!');
                  }
                }),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                height: 90.0,
                width: double.infinity,
                child: _buildDefaultBtn("SALVAR NA NUVEM", () {
                  if (UserSession.name.isEmpty) {
                    _showMsgMustCreateUser();
                  }
                }),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                height: 90.0,
                width: double.infinity,
                child: _buildDefaultBtn("BAIXAR DA NUVEM", () {
                  if (UserSession.name.isEmpty) {
                    _showMsgMustCreateUser();
                  }
                }),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                height: 90.0,
                width: double.infinity,
                child: _buildDefaultBtn("APAGAR TAREFAS", () => {

                }),
              ),
            ]
        )
    );
  }

  Widget _buildDefaultText(String text, double size) {
    return Text(
        text,
        style: TextStyle(color: Colors.orange, fontSize: size)
    );
  }

  Widget _buildDefaultBtn(String text, Function func) {
    return RaisedButton(
        onPressed: func,
        child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18.0)
        ),
        color: Colors.orange
    );
  }

  void _buildDialog(BuildContext context, String title, Widget content) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            new FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK")
            )
          ],
        );
      }
    );
  }

  void _saveUserDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: _formKey,
            child: AlertDialog(
              title: Text("Cadastrar usuário"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: _textFieldNameController,
                    decoration: InputDecoration(hintText: "Nome"),
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Preencha o nome";
                        }
                      }
                  ),
                  TextFormField(
                    controller: _textFieldEmailController,
                    decoration: InputDecoration(hintText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Preencha o email";
                        }
                      }
                  ),
                ],
              ),
              actions: <Widget>[
                new FlatButton(
                  child: Text("Salvar"),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      var name = _textFieldNameController.text;
                      var email = _textFieldEmailController.text;
                      var user = User(DateTime.now().millisecondsSinceEpoch, name.toUpperCase(), email.toLowerCase());
                      _saveUser(user);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                new FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () { Navigator.of(context).pop(); },
                )
              ],
            ),
          );
        });
  }

  void _saveUser(User user) {

    DatabaseHandler.getDatabase().then((db) => {
      UserRepository.insert(user, db).then((value) {
        print('User saved!');
        UserSession.name = user.name;
        UserSession.email = user.email;
      })
      .catchError((onError, error) {
        print('Error try save user!');
        print(onError);
        print(error);
      })
    }).catchError((onError) => print('Erro ao tentar abrir banco!'));
  }

  void _showMsgMustCreateUser() {
    _buildDialog(
        context,
        "Cadastre um usuário",
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDefaultText("Você precisa de um usuário cadastrado para sincronizar ocm a nuvem.", 16)
          ],
        )
    );
  }

}