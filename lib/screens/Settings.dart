import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/data/model/User.dart';
import 'package:fiap_trabalho_flutter/data/service/LogUtils.dart';
import 'package:fiap_trabalho_flutter/data/utils/UserSession.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:fiap_trabalho_flutter/screens/utils/DialogUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

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

  final userSession = GetIt.instance.get<UserSession>();
  Controller mController;

  @override
  Widget build(BuildContext context) {

    mController = Provider.of<Controller>(context);

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: appDarkGreyColor,
        resizeToAvoidBottomPadding: false,
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
                          child: Icon(Icons.arrow_back, size: 28, color:  mainColor),
                          onTap: () => { Navigator.of(context).pop() },
                        ),
                        SizedBox(width: 24),
                        Center(
                            child: _buildDefaultText("Configurações", 24)
                        )
                      ]
                  )
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(top: 48),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                      height: 90.0,
                      width: double.infinity,
                      child: _buildDefaultBtn("CADASTRAR EMAIL", () {
                        if (userSession.name == null || userSession.name.isEmpty)
                          _saveUserDialog(context);
                        else {
                          _buildDialog(
                              context,
                              "Usuário já cadastrado",
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildDefaultText(userSession.name, 16),
                                  _buildDefaultText(userSession.email, 16)
                                ],
                              )
                          );
                          LogUtils.info('User exists!');
                        }
                      }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                      height: 90.0,
                      width: double.infinity,
                      child: _buildDefaultBtn("SALVAR NA NUVEM", () {
                        if (userSession.name == null || userSession.name.isEmpty) {
                          _showMsgMustCreateUser();
                        } else
                          DialogUtils.makeYesNoDialog(context, "Deseja salvar tarefas na nuvem?", () => mController.saveTaskFirebase(context, userSession));
                      }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                      height: 90.0,
                      width: double.infinity,
                      child: _buildDefaultBtn("BAIXAR DA NUVEM", () {
                        if (userSession.name == null || userSession.name.isEmpty) {
                          _showMsgMustCreateUser();
                        } else
                          DialogUtils.makeYesNoDialog(context, "Deseja baixar tarefas da nuvem?", () => mController.getTasks(context, userSession));
                      }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                      height: 90.0,
                      width: double.infinity,
                      child: _buildDefaultBtn("APAGAR TAREFAS", () {
                        if (userSession.name == null || userSession.name.isEmpty) {
                          _showMsgMustCreateUser();
                        } else
                          DialogUtils.makeYesNoDialog(context, "Deseja apagar todas as tarefas?", () => mController.removeTasks(context, userSession));
                      }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                      height: 90.0,
                      width: double.infinity,
                      child: _buildDefaultBtn("APAGAR USUÁRIO", () {
                        if (userSession.name == null || userSession.name.isEmpty) {
                          _showMsgMustCreateUser();
                        } else
                          DialogUtils.makeYesNoDialog(context, "Deseja remover o usuário?", () => mController.removeUser(context, userSession));
                      }),
                    ),
                  ],
                ),
              )
            ]
        )
    );
  }

  Widget _buildDefaultText(String text, double size) {
    return Text(
        text,
        style: TextStyle(color: mainColor, fontSize: size)
    );
  }

  Widget _buildDefaultBtn(String text, Function func) {
    return RaisedButton(
        onPressed: func,
        child: Text(
            text,
            style: TextStyle(color: mainAccentColor, fontSize: 18.0)
        ),
        color: mainColor
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
                      var user = User(
                          DateTime.now().millisecondsSinceEpoch.toString(),
                          name.toUpperCase(),
                          email.toLowerCase()
                      );
                      mController.saveFirebaseUser(user, userSession);
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

  void _showMsgMustCreateUser() {
    _buildDialog(
        context,
        "Cadastre um usuário",
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDefaultText("Você precisa de um usuário cadastrado para sincronizar com a nuvem.", 16)
          ],
        )
    );
  }


}