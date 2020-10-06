import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/data/utils/UserSession.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:fiap_trabalho_flutter/screens/About.dart';
import 'package:fiap_trabalho_flutter/screens/ListTasks.dart';
import 'package:fiap_trabalho_flutter/screens/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'NewTask.dart';
import 'Utils.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final userSession = GetIt.instance.get<UserSession>();
  Controller mController;

  @override
  Widget build(BuildContext context) {

    mController = Provider.of<Controller>(context);
    mController.loadTaskList();

    mController.firebaseLogin(userSession);

    return Scaffold(
      backgroundColor: appDarkGreyColor,
      key: _scaffoldKey,
      body: Observer(builder: (_) {
        if (!mController.logged) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        } else {
          return Stack(
            children: <Widget>[
              _buildContent(),
            ],
          );
        }
      })
    );
  }

  Widget _buildContent() {
    return Center (
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Column(
          children: <Widget> [
            _buildDefaultText("Lista de Tarefas", 28),
            _buildDefaultText("FIAP - Trabalho Flutter", 18),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.fromLTRB(40, 16, 40, 16),
              height: 90.0,
              width: double.infinity,
              child: _buildDefaultBtn("Tarefas", () =>
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ListTasks()))
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 16, 40, 16),
              height: 90.0,
              width: double.infinity,
              child: _buildDefaultBtn("Criar Tarefa", () =>
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NewTask()))
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(40, 16, 40, 16),
              height: 90.0,
              width: double.infinity,
              child: _buildDefaultBtn("Utils", () =>
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Utils()))
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 16, 40, 16),
              height: 90.0,
              width: double.infinity,
              child: _buildDefaultBtn("Configurações", () =>
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Settings()))
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 16, 40, 16),
              height: 90.0,
              width: double.infinity,
              child: _buildDefaultBtn("Sobre", () =>
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => About()))
              ),
            )
          ],
        )
      ),
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

  Widget _buildDefaultText(String text, double size) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(text,
          style: TextStyle(color: mainColor, fontSize: size)),
    );
  }

}