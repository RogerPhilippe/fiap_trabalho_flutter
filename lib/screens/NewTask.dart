import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {

  @override
  Widget build(BuildContext context) {

    final _scaffoldKey = new GlobalKey<ScaffoldState>();
    final _textEditingTaskTitle = TextEditingController();
    final _textEditingTaskDescription = TextEditingController();

    return Scaffold(
      backgroundColor: appDarkGreyColor,
      key: _scaffoldKey,
      body: _buildBody(),
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
    return Center (
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Column(
                children: <Widget> [
                  _buildDefaultText("Criar Tarefas", 28),
                ]
            )
        )
    );
  }

  Widget _buildDefaultText(String text, double size) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(text,
          style: TextStyle(color: Colors.orange, fontSize: size)),
    );
  }

}