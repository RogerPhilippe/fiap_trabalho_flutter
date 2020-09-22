import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiap_trabalho_flutter/data/DatabaseHandler.dart';
import 'package:fiap_trabalho_flutter/data/model/User.dart';
import 'package:fiap_trabalho_flutter/data/repository/UserRepository.dart';
import 'package:fiap_trabalho_flutter/data/service/FirebaseService.dart';
import 'package:fiap_trabalho_flutter/data/service/LogUtils.dart';
import 'package:fiap_trabalho_flutter/data/utils/UserSession.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:firebase_core/firebase_core.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {

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
              SingleChildScrollView(
                padding: EdgeInsets.only(top: 48),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                      height: 90.0,
                      width: double.infinity,
                      child: _buildDefaultBtn("CADASTRAR EMAIL", () {
                        if (UserSession.name == null || UserSession.name.isEmpty)
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
                          LogUtils.info('User exists!');
                        }
                      }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                      height: 90.0,
                      width: double.infinity,
                      child: _buildDefaultBtn("SALVAR NA NUVEM", () {
                        if (UserSession.name == null || UserSession.name.isEmpty) {
                          _showMsgMustCreateUser();
                        }
                      }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                      height: 90.0,
                      width: double.infinity,
                      child: _buildDefaultBtn("BAIXAR DA NUVEM", () {
                        if (UserSession.name == null || UserSession.name.isEmpty) {
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
                    Container(
                      padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                      height: 90.0,
                      width: double.infinity,
                      child: _buildDefaultBtn("APAGAR USUÁRIO", () => {

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
                      var user = User(
                          DateTime.now().millisecondsSinceEpoch.toString(),
                          name.toUpperCase(),
                          email.toLowerCase()
                      );
                      _saveFirebaseUser(user);
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

  void _saveFirebaseUser(User user) {

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    FirebaseService.findUserFirestore(user, firestore).then((documentSnapshot) {
      if (documentSnapshot != null && documentSnapshot.docs.isNotEmpty) {

        var doc = documentSnapshot.docs[0];
        var data = doc.data();
        LogUtils.info('Usuário já cadastrado na nuvem: ${data["userEmail"]}');
        _saveUser(user);

      } else {

        LogUtils.info('Usuário não existe na nuvem.');

          FirebaseService.saveFireStore(user, firestore)
              .then((value) {
            LogUtils.info('User saved in Firebase');
                _saveUser(user);
              })
              .catchError((onError) {
            LogUtils.error('Erro ao tentar salvar no firebase!');
              });
      }
    }).catchError((onError) => LogUtils.error('Erro ao buscar usuário na nuvem.'));

  }

  void _saveUser(User user) {

    DatabaseHandler.getDatabase().then((db) => {
      UserRepository.insert(user, db).then((value) {
        LogUtils.info('User saved local db!');
        UserSession.userID = user.id;
        UserSession.name = user.name;
        UserSession.email = user.email;
      })
          .catchError((onError, error) {
        LogUtils.error('Error try save user!');
        LogUtils.error(onError);
        LogUtils.error(error);
      })
    }).catchError((onError) => LogUtils.error('Erro ao tentar abrir banco!'));
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