import 'package:fiap_trabalho_flutter/data/controllers/Controller.dart';
import 'package:fiap_trabalho_flutter/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class NewTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskTodoDateController = TextEditingController();
  bool _loading = true;

  @override
  Widget build(BuildContext context) {

    var controller = Provider.of<Controller>(context);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      backgroundColor: appDarkGreyColor,
      body: _buildBody(controller),
    );
  }

  // Body
  Widget _buildBody(Controller controller) {
    return Stack(
      children: <Widget>[
        _buildContent(controller),
      ],
    );
  }

  Widget _buildContent(Controller controller) {
    return SafeArea(
      child: Column(
        children: [
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
                        child: _buildDefaultText("Criar Tarefas", 24)
                    )
                  ]
              )
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: _formContent(controller),
          )
        ],
      ),
    );
  }

  Widget _formContent(Controller controller) {
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
                    hintStyle: TextStyle(color: Colors.orange),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)
                    )
                ),
                controller: taskTitleController,
                onChanged: controller.setName,
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
                    hintStyle: TextStyle(color: Colors.orange),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)
                    )
                ),
                controller: taskDescriptionController,
                onChanged: controller.setDescription,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Data",
                    hintStyle: TextStyle(color: Colors.orange),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)
                    )
                ),
                controller: taskTodoDateController,
                onChanged: controller.setDateTodo,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
              height: 90.0,
              width: double.infinity,
              child: _buildSaveBtn(controller)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultText(String text, double size) {
    return Container(
      child: Text(text,
          style: TextStyle(color: Colors.orange, fontSize: size)),
    );
  }

  Widget _buildSaveBtn(Controller controller) {
    return RaisedButton(
        onPressed: () {
          if(_formKey.currentState.validate()) {
            controller.saveTask();
          }
        },
        child: Text(
            "SALVAR",
            style: TextStyle(color: Colors.white, fontSize: 18.0)
        ),
        color: Colors.orange
    );
  }

}