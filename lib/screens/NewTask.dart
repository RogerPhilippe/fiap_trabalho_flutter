import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:fiap_trabalho_flutter/screens/ListTasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import './utils/DateUtils.dart';

class NewTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {

  Controller mController;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskTodoDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    mController = Provider.of<Controller>(context);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      backgroundColor: appDarkGreyColor,
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
    return SafeArea(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(16, 28, 16, 28),
              child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(Icons.arrow_back, size: 28, color: mainColor),
                      onTap: () => { Navigator.of(context).pop() },
                    ),
                    SizedBox(width: 24),
                    Center(
                        child: _buildDefaultText("Criar Tarefas", 24)
                    )
                  ]
              )
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: _formContent(),
          )
        ],
      ),
    );
  }

  Widget _formContent() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Tarefa",
                    hintStyle: TextStyle(color: mainColor),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor)
                    )
                ),
                controller: taskTitleController,
                onChanged: mController.setName,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return "Preencha o campo.";
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Detalhes",
                    hintStyle: TextStyle(color: mainColor),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor)
                    )
                ),
                controller: taskDescriptionController,
                onChanged: mController.setDescription,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: DateUtils().dateField(mController)
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
              height: 90.0,
              width: double.infinity,
              child: _buildSaveBtn()
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultText(String text, double size) {
    return Container(
      child: Text(text,
          style: TextStyle(color: mainColor, fontSize: size)),
    );
  }

  Widget _buildSaveBtn() {
    return RaisedButton(
        onPressed: () {
          if(_formKey.currentState.validate()) {
            mController.saveTask().then((status) => {
              if(status)
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) => ListTasks()))
            });
          }
        },
        child: Text(
            "Salvar",
            style: TextStyle(color: mainAccentColor, fontSize: 18.0)
        ),
        color: mainColor
    );
  }

}