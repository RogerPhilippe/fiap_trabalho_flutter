import 'package:fiap_trabalho_flutter/data/DatabaseHandler.dart';
import 'package:fiap_trabalho_flutter/data/repository/UserRepository.dart';
import 'package:fiap_trabalho_flutter/data/utils/UserSession.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:fiap_trabalho_flutter/screens/About.dart';
import 'package:fiap_trabalho_flutter/screens/ListTasks.dart';
import 'package:fiap_trabalho_flutter/screens/Settings.dart';
import 'package:flutter/material.dart';

import 'NewTask.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHandler.getDatabase().then((db) {
     UserRepository.findAll(db).then((users) {
       UserSession.name = users[0].name;
       UserSession.email = users[0].email;
       _showContent();
     }).catchError((onError) {
       print('Error find user.');
       _showContent();
     });
    }).catchError((onError) {
      print('Error try open db.');
      _showContent();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appDarkGreyColor,
      key: _scaffoldKey,
      body: _buildBody(),
    );
  }

  // Body
  Widget _buildBody() {
    if (_loading) {
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
  }

  Widget _buildContent() {
    return Center (
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Column(
          children: <Widget> [
            _buildDefaultText("Lista de Tarefas", 28),
            _buildDefaultText("FIAP - Trabalho Final", 18),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
              height: 90.0,
              width: double.infinity,
              child: _buildDefaultBtn("TAREFAS", () =>
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ListTasks()))
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
              height: 90.0,
              width: double.infinity,
              child: _buildDefaultBtn("CADASTRAR", () =>
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NewTask()))
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
              height: 90.0,
              width: double.infinity,
              child: _buildDefaultBtn("CONFIGURAÇÕES", () =>
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Settings()))
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
              height: 90.0,
              width: double.infinity,
              child: _buildDefaultBtn("SOBRE", () =>
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
            style: TextStyle(color: Colors.white, fontSize: 18.0)
        ),
        color: Colors.orange
    );
  }

  Widget _buildDefaultText(String text, double size) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(text,
          style: TextStyle(color: Colors.orange, fontSize: size)),
    );
  }

  void _showContent() {
    _loading = false;
    setState(() => print(''));
  }

}